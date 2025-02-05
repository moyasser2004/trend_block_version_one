import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_state.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Pages/EditPage.dart';
import 'package:trend/features/profile/presentation/Pages/my_profile/widgets/AnimatedAvatarWidget.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/custom_Backdrop_Filter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final currentUser user;
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        print(
            "${state}+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        if (state is Updatesuccess) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString("avatar", state.avatar);
          // // await sharedPreferences.setString("bio", state.bio);
          // await sharedPreferences.setString("fullName", state.full_name);
          BlocProvider.of<ProfileBloc>(context)
              .add(getPostForUserevent(id: widget.user.id));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Editpage(
              user: widget.user,
              onTap: () {
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
                avatarUrl: 'http://167.71.92.176${widget.user.avatar}')
          ],
        );
      },
    );
  }
}
