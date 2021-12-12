import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model/post_model.dart';
import 'package:social_app/moduls/comment/comment_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/style/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutScreenStates>(
      listener: (contest, state) {},
      builder: (contest, state) {
        return ConditionalBuilder(
          condition: SocialLayoutCubit.get(context).posts.length > 0,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Image(
                        width: double.infinity,
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/discontent-female-model-with-black-skin-picks-up-trash-points-plastic-wastes-displeasure-does-volunteer-work-protects-environment-stands-blue-wall-with-free-space-your-text_273609-26480.jpg?size=338&ext=jpg'),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate  with friends',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black87,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      SocialLayoutCubit.get(context).posts[index],
                      context,
                      index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.0,
                  ),
                  itemCount: SocialLayoutCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          fallback: (context) =>
              Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name!.substring(0, 20)}',
                              style: TextStyle(
                                fontSize: 16.0,
                                height: 1.4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 16.0,
                              color: defaultColor,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dataTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 17.0,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(vertical: 10.0),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black87,
                    ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 10.0,
              //     bottom: 5.0,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Container(
              //           height: 20.0,
              //           child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: Text(
              //               '#software',
              //               style:
              //                   Theme.of(context).textTheme.caption!.copyWith(
              //                         color: defaultColor,
              //                       ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: NetworkImage('${model.postImage}'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 17.0,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialLayoutCubit.get(context).likes[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 14.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat,
                                size: 17.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '0 comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 14.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(vertical: 10.0),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              '${SocialLayoutCubit.get(context).userModel!.image}',
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'write a comment ...',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 14.0,
                                    ),
                          ),
                        ],
                      ),
                      onTap: () {
                        navigateTo(
                          context,
                          CommentScreen(),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialLayoutCubit.get(context).createLike(
                          SocialLayoutCubit.get(context).postsId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 17.0,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'like',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 14.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
