import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/State_Following.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/bloc_folllowing.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/event_Following.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/bloc_get.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/event_getU.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';

class FollowingButton extends StatelessWidget {
  const FollowingButton({super.key, required this.user});
  final ProfileModel user;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowingBloc, FollowingState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        if (state is UnFollowingLoadding || state is FollowingLoadding) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else {
          bool x = user.isFollowed;
          return ElevatedButton(
              onPressed: () async {
                !user.isFollowed
                    ? BlocProvider.of<FollowingBloc>(context)
                        .add(FollowUserEvent(user.id))
                    : BlocProvider.of<FollowingBloc>(context)
                        .add(UnFollowUserEvent(user.id));
                BlocProvider.of<UserBloc>(context)
                    .add(FetchUserEventForUpdate(user.id));
                SharedPreferences d = await SharedPreferences.getInstance();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
              child: !x
                  ? Text(
                      'Follow',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Following',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ));
        }
      },
    );
  }
}
