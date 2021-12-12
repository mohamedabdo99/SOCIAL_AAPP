import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/style/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;

  const ChatDetailsScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(
      builder: (BuildContext context) {
        SocialLayoutCubit.get(context).getMessages(
          receiverId: userModel.uid as String,
        );
        return BlocConsumer<SocialLayoutCubit, SocialLayoutScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      //${model.name!.substring(0, 20)}
                      '${userModel.name}',
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialLayoutCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context , index) {
                            var message = SocialLayoutCubit.get(context).messages[index];
                            if(SocialLayoutCubit.get(context).userModel!.uid == message.senderId)
                              return buildSendMessage(message);

                            return  buildReceiverMessage(message);

                          },
                          separatorBuilder: (context , index) => SizedBox(
                            height: 16.0,
                          ),
                          itemCount: SocialLayoutCubit.get(context).messages.length,
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: messageController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Aa',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: defaultColor,
                              height: 50.0,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialLayoutCubit.get(context).sendMessage(
                                    receiverId: userModel.uid as String,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  Icons.send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSendMessage( MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          )),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Text(
        '${model.text}',
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ),
  );

  Widget buildReceiverMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: defaultColor.withOpacity(4.0,),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          )),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Text(
        '${model.text}',
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ),
  );
}


