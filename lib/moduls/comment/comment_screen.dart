import 'package:flutter/material.dart';
import 'package:social_app/shared/components/components.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  // SocialLayoutCubit.get(context).createComment(SocialLayoutCubit.get(context).postsId[index]);
  @override
  Widget build(BuildContext context) {

    var commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'comments',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black,
              ),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
