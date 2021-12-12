import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/moduls/feeds/feeds_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/style/colors.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
        ),
        titleSpacing: .4,
        actions: [
          defaultTextButton(
            function: () {
              var time = DateTime.now();
              if (SocialLayoutCubit.get(context).postImage == null) {
                SocialLayoutCubit.get(context).crateNewPost(
                  dataTime: time.toString(),
                  text: textController.text,
                );
              }
              if (SocialLayoutCubit.get(context).postImage != null) {
                SocialLayoutCubit.get(context).uploadPostImage(
                  dataTime: time.toString(),
                  text: textController.text,
                );
              }
            },
            text: 'Post',
            textColor: defaultColor,
          ),
        ],
      ),
      body: BlocConsumer<SocialLayoutCubit, SocialLayoutScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialLayoutCubit.get(context).userModel;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${cubit!.image}',
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${cubit.name}',
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      hintText: 'what is on your mined..',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialLayoutCubit.get(context).postImage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: FileImage(SocialLayoutCubit.get(context).postImage as File),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 18.0,
                          ),
                        ),
                        onPressed: () {
                          SocialLayoutCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialLayoutCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: defaultColor,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Add a Photo',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# tags',
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
