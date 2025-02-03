import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/Following_Button.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/Messagebutton.dart';

class Followingandmessage extends StatelessWidget {
  const Followingandmessage({super.key, required this.user});
  final ProfileModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 30.w),
        Container(
          width: 145.w,
          height: 28.h,
          child: Expanded(
            child: FollowingButton(
              user: user,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Messagebutton(),
        SizedBox(width: 30.w),
      ],
    );
  }
}
