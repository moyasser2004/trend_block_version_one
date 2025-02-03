import 'package:flutter/material.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';
import 'package:trend/features/profile/presentation/Pages/my_profile/widgets/AnimatedAvatarWidget.dart';
import 'package:trend/features/profile/presentation/Pages/my_profile/widgets/body_Myprofile.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/custom_Backdrop_Filter.dart';

import '../../../../../shared/core/local/SharedPreferencesDemo.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  currentUser user = currentUser(
      id: 1,
      username: "username",
      email: "email",
      fullName: "fullName",
      avatar: "avatar",
      bio: 'bio',
      mobile: '',
      followers: '',
      following: '',
      totalPosts: '0', // Default value
      totalLikes: '0',
      is_private: false // Default value
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
  }

  @override
  Future<void> _loadUserData() async {
    user = await SharedPreferencesDemo.loadUserData();
    setState(() {
      // تحديث الواجهة عند تحميل البيانات إذا لزم الأمر
    });
  }

  bool is_visible = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BodyForMyProfile(
          onLongPress: () {
            setState(() {
              is_visible = !is_visible;
            });
          },
        ),
        customBackdropFilter(
          is_visible: is_visible,
          onPointerUp: (event) {
            setState(() {
              is_visible = !is_visible;
            });
          },
        ),
        AnimatedAvatarWidget(
          isVisible: is_visible,
          avatarUrl: user.avatar,
        )
      ],
    );
  }
}
