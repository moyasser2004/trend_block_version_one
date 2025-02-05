import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_get_User/bloc_get.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_get_User/states.getU.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_state.dart';
import 'package:trend/features/profile/presentation/Pages/my_profile/widgets/AnimatedAvatarWidget.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/body_User_profile.dart';
import 'package:trend/features/profile/presentation/Pages/user_profile/widgets/custom_Backdrop_Filter.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool is_visible = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        // if (state is UserLoadedState) {
        //   // BlocProvider.of<ProfileBloc>(context)
        //   //     .add(getPostForUserevent(id: state.user.id));
        // }
      },
      builder: (context, state) {
        if (state is UserLoadedState) {
          final user = state.user;
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Stack(
                children: [
                  BodyuserProfile(
                    user: user,
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
            },
          );
        } else if (state is UserLoadingState) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ));
        } else {
          return Scaffold(body: Text("Page Not Found"));
        }
      },
    );
  }
}
