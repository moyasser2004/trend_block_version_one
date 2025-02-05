import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/Block_tile.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/CustomBioTile.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/Delete_tile.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/custom_app_bar.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/logout_tile.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/profile_avatar.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/profile_info_tile.dart';

class Editpage extends StatefulWidget {
  const Editpage({super.key, required this.user, this.onTap});

  final currentUser user;
  final void Function()? onTap;
  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  File? _selectedImage; // لتخزين الصورة المختارة
  final ImagePicker _picker = ImagePicker(); // لإنشاء مثيل لالتقاط الصور
  late String username = "";
  late String fullname = "";
  late String bio = "";
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    } else {}
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    } else {}
  }

  void pickAvatarImage() async {
    await _pickImageFromCamera();
  }

  bool is_visible = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading, // عرض شاشة التحميل عند true
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "Edit my profile",
          userId: widget.user.id,
          fullname: fullname,
          bio: bio,
          selectedImage: _selectedImage,
          onPressed: () {
            if (_selectedImage != null) {
              BlocProvider.of<ProfileBloc>(context)
                  .add(UpdateAvatar(widget.user.id, _selectedImage!));
            }
            setState(() {
              isLoading = true;
            });
          },
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.sp,
            ),
            ProfileAvatar(
              onTap: widget.onTap,
              avatarUrl: widget.user.avatar,
              selectedImage: _selectedImage,
              pickImageFromCamera: _pickImageFromCamera,
              pickImage: _pickImage,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  Text(
                    "Personal Informations",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  ProfileInfoTile(
                    property: fullname,
                    userpro: widget.user.fullName,
                    onChanged: (newFullName) {
                      setState(() {
                        fullname = newFullName;
                      });
                    },
                    onCancel: () {
                      setState(() {
                        fullname = '';
                      });
                    },
                    userid: widget.user.id,
                  ),
                  CustomBioTile(
                    userid: widget.user.id,
                    bio: bio, // Pass the current bio
                    onBioChanged: (newBio) {
                      setState(() {
                        bio = newBio;
                      });
                    },
                    userBio:
                        widget.user.bio, // Pass the initial bio from the user
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Other",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                  blockTile(
                    id: widget.user.id,
                  ),
                  DeleteTile(),
                  LogoutTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
