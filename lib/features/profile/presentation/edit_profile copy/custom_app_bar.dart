import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_bloc.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_event.dart';

import '../../../../shared/utiles/profile_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int userId;
  final String fullname;
  final String bio;
  final File? selectedImage;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.userId,
    required this.fullname,
    required this.bio,
    required this.selectedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () async {
          BlocProvider.of<ProfileBloc>(context)
              .add(getPostForUserevent(id: userId));
          Navigator.pop(context);
        },
        child: Row(
          children: [
            SizedBox(width: 19.sp),
            SvgPicture.asset(
              "assets/icons/Alt Arrow Left.svg",
              height: 14,
              width: 6,
              fit: BoxFit.none,
            ),
            SizedBox(width: 5.sp),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff000000),
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            ProfileHelper.saveProfile(
                context, userId, fullname, bio, selectedImage);
          },
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
