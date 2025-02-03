import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/authentication/presentation/pages/login.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_bloc.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_event.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_state.dart';

class ProfileHelper {
  static void saveProfile(BuildContext context, int userId, String fullname,
      String bio, File? selectedImage) {
    if (fullname.isNotEmpty) {
      BlocProvider.of<ProfileBloc>(context)
          .add(Updatefullname(userId, fullname));
    }

    if (bio.isNotEmpty) {
      BlocProvider.of<ProfileBloc>(context).add(Updatebio(userId, bio));
    }

    if (selectedImage != null) {
      BlocProvider.of<ProfileBloc>(context)
          .add(UpdateAvatar(userId, selectedImage));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile saved successfully!")),
    );
  }

  static void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is Deletesuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
          },
          builder: (context, state) {
            if (state is DeleteLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else {
              return AlertDialog(
                title: Text("Delete Confirmation"),
                content: Text("Are you sure you want to delete this Account?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // إغلاق الـ Dialog
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<ProfileBloc>(context).add(Delete());
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
