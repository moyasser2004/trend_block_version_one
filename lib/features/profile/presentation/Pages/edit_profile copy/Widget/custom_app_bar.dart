import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_state.dart';

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
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: TextButton(
            onPressed: () {
              // ProfileHelper.saveProfile(
              //     context, userId, fullname, bio, selectedImage);
              if (fullname.isNotEmpty) {
                BlocProvider.of<ProfileBloc>(context)
                    .add(Updatefullname(userId, fullname));
              }

              if (bio.isNotEmpty) {
                BlocProvider.of<ProfileBloc>(context)
                    .add(Updatebio(userId, bio));
              }

              if (selectedImage != null) {
                BlocProvider.of<ProfileBloc>(context)
                    .add(UpdateAvatar(userId, selectedImage!));
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Profile saved successfully!")),
              );

              Navigator.pop(context);
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
