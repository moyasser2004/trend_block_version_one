import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/features/profile/presentation/user_profile/widgets/DisplayPrivateOrPosts.dart';
import 'package:trend/features/profile/presentation/user_profile/widgets/FollowingAndMessage.dart';
import 'package:trend/features/profile/presentation/user_profile/widgets/UserFeatures.dart';
import 'package:trend/features/profile/presentation/user_profile/widgets/avatar_And_Name.dart';

class BodyuserProfile extends StatelessWidget {
  const BodyuserProfile({super.key, required this.user, this.onLongPress});
  final ProfileModel user;
  final void Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Enables smooth scrolling
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarAndName(
                onLongPress: onLongPress!,
                user: user,
              ),
              SizedBox(height: 5.h),
              UserFeatures(
                user: user,
              ),
              SizedBox(height: 7.h),
              Followingandmessage(
                user: user,
              ),
              SizedBox(height: 7.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  // '${user.bio}.\n📍 Location: ${user.location}\n📞 Phone: +234 901 234 5678',
                  'Live my own life as i want\n📍 sws 🇨🇭 \n📞 Cell +234 901 234 5678',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
              ),
              PrivateOrDiplayPosts(
                user: user,
              )
            ],
          ),
        ),
      ),
    );
  }
}
