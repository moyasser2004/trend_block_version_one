import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/add_post/bloc/Add_Post_State.dart';
import 'package:trend/features/add_post/bloc/Add_Post_cubit.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/State_Following.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/bloc_folllowing.dart';
import 'package:trend/features/profile/All_Bloc/Display_Following_bloc/followers_bloc.dart';
import 'package:trend/features/profile/All_Bloc/Display_Following_bloc/followers_event.dart';
import 'package:trend/features/profile/All_Bloc/Display_followerBloc/followers_bloc.dart';
import 'package:trend/features/profile/All_Bloc/Display_followerBloc/followers_event.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';
import 'package:trend/features/profile/presentation/Followers/Followers_main.dart';
import 'package:trend/features/profile/presentation/edit_profile%20copy/edit_profile.dart';
import 'package:trend/features/profile/presentation/my_profile/widgets/DisplayBio.dart';
import 'package:trend/features/profile/presentation/my_profile/widgets/Dsiplay_My_posts_in_body.dart';
import 'package:trend/features/profile/presentation/my_profile/widgets/EditAndSetting.dart';
import 'package:trend/features/profile/presentation/my_profile/widgets/MyNameAndAvatar.dart';
import 'package:trend/features/profile/presentation/user_profile/widgets/custom_User_feature_wighet.dart';

import '../../../../../shared/core/local/SharedPreferencesDemo.dart';



class BodyForMyProfile extends StatefulWidget {
  const BodyForMyProfile({super.key, this.onLongPress});

  final void Function()? onLongPress;
  @override
  State<BodyForMyProfile> createState() => _BodyForMyProfileState();
}

class _BodyForMyProfileState extends State<BodyForMyProfile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Enables smooth scrolling
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Mynameandavatar(
                onLongPress: widget.onLongPress,
                user: user,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocConsumer<AddPostBloc, AddPostState>(
                      listener: (context, state) {
                        if (state is AddPostSuccess) {
                          setState(() {
                            _loadUserData();
                          });
                        }
                      },
                      builder: (context, state) {
                        return CustomUserFeatureWighet(
                            number: user.totalPosts, name: "Posts");
                      },
                    ),
                    BlocConsumer<FollowingBloc, FollowingState>(
                      listener: (context, state) {
                        if (state is FollowingSuccess ||
                            state is UnFollowingSuccess) {
                          setState(() {
                            _loadUserData();
                          });
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<FollowersBloc>(context)
                                .ListFollower
                                .clear();
                            BlocProvider.of<FollowersBloc>(context)
                                .add(LoadFollowers(id: user.id));

                            BlocProvider.of<DisplayFollowingBloc>(context)
                                .add(LoadFollowing1(id: user.id));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FollowersScreen(
                                          user: user,
                                          index: 0,
                                        )));
                          },
                          child: CustomUserFeatureWighet(
                              number: user.followers, name: "Followers"),
                        );
                      },
                    ),
                    BlocConsumer<FollowingBloc, FollowingState>(
                      listener: (context, state) {
                        if (state is FollowingSuccess ||
                            state is UnFollowingSuccess) {
                          setState(() {
                            _loadUserData();
                          });
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<FollowersBloc>(context)
                                .add(LoadFollowers(id: user.id));
                            BlocProvider.of<DisplayFollowingBloc>(context)
                                .add(LoadFollowing1(id: user.id));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FollowersScreen(
                                          user: user,
                                          index: 1,
                                        )));
                          },
                          child: CustomUserFeatureWighet(
                              number: user.following, name: "Following"),
                        );
                      },
                    ),
                    CustomUserFeatureWighet(
                        number: user.totalLikes, name: "Likes"),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Editandsetting(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                                user: user,
                              ))).then((onValue) {
                    setState(() {
                      _loadUserData();
                    });
                  });
                },
              ),
              SizedBox(height: 10.h),
              Displaybio(
                user: user,
              ),
              SizedBox(height: 10.h),
              DsiplayMyPostsInBody()
            ],
          ),
        ),
      ),
    );
  }
}
