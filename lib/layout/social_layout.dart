import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/moduls/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutScreenStates>(
      listener: (context, state) {
        if (state is SocialLayoutAddPostState) {
          navigateTo(
              context,
              NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
            ],
            title: Text(
              cubit.title[cubit.currentIndex],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
          ),
        );
      },
    );
  }
}
