import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/style/colors.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();

    var userModel = SocialLayoutCubit.get(context).userModel;
    var profileImage = SocialLayoutCubit.get(context).profileImage;
    var coverImage = SocialLayoutCubit.get(context).coverImage;

    nameController.text = userModel!.name!;
    bioController.text = userModel.bio!;
    phoneController.text = userModel.phone!;

    return BlocConsumer<SocialLayoutCubit, SocialLayoutScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialLayoutCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5.0,
            title: const Text('Edit Profile'),
            actions: [
              defaultTextButton(
                radius: 0.0,
                textColor: defaultColor,
                function: () {
                  SocialLayoutCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                text: 'UPDATE',
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUpdateLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
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
                                      image: coverImage == null
                                          ? NetworkImage('${userModel!.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera,
                                  size: 18.0,
                                ),
                              ),
                              onPressed: () {
                                SocialLayoutCubit.get(context).getCoverImage();
                              },
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${userModel!.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera,
                                  size: 18.0,
                                ),
                              ),
                              onPressed: () {
                                SocialLayoutCubit.get(context)
                                    .getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialLayoutCubit.get(context).profileImage != null ||
                      SocialLayoutCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialLayoutCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialLayoutCubit.get(context)
                                        .uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload profile',
                                  height: 40.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                if (state is SocialUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 8.0,
                        ),
                        if (SocialLayoutCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                      SocialLayoutCubit.get(context)
                                        .uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload cover',
                                  height: 40.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                if (state is SocialUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFiled(
                    controller: nameController,
                    suffix: Icons.person,
                    type: TextInputType.name,
                    label: 'name',
                    validate: (String value) {},
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFiled(
                    controller: bioController,
                    suffix: Icons.info,
                    type: TextInputType.text,
                    label: 'bio',
                    validate: (String value) {},
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFiled(
                    controller: phoneController,
                    suffix: Icons.phone,
                    type: TextInputType.number,
                    label: 'phone',
                    validate: (String value) {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
