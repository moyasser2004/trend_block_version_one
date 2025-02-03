import 'package:flutter/material.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/PrivateWidget.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/posts_in_user_body.dart';

class PrivateOrDiplayPosts extends StatelessWidget {
  const PrivateOrDiplayPosts({super.key, required this.user});
  final ProfileModel user;
  @override
  Widget build(BuildContext context) {
    return (user.isPrivate && !user.isFollowed)
        ? PrivateWidget()
        : PostsInUserBody();
  }
}
