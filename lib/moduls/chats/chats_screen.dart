import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/moduls/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialLayoutCubit
              .get(context)
              .users
              .length > 0,
          builder: (context) =>
              ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildChatItem(SocialLayoutCubit
                        .get(context)
                        .users[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialLayoutCubit
                    .get(context)
                    .users
                    .length,
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) =>
      InkWell(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '${model.name}',
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
        onTap: () {
          navigateTo(context, ChatDetailsScreen(
            userModel: model,
          ),);
        },
      );
}
