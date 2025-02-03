import 'package:flutter/material.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/presentation/activities_post.dart';
import 'package:trend/features/posts/presentation/body_post.dart';
import 'package:trend/features/posts/presentation/header_post.dart';

class MainPost extends StatelessWidget {
  final PostModel post;
  final int index;
  MainPost({Key? key, required this.post, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderPost(post: post),
        BodyPost(post: post),
        ActivitiesPost(
          post: post,
          postIndex: index,
        ),
      ],
    );
  }
}
