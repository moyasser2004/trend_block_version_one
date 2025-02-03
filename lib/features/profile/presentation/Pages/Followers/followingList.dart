import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/Display_Following_bloc/followers_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/Display_Following_bloc/followers_state.dart';
import 'package:trend/features/profile/presentation/Manager/Display_followerBloc/followers_state.dart';
import 'package:trend/features/profile/presentation/Pages/Followers/FollowersShimmer.dart';
import 'package:trend/features/profile/presentation/Pages/Followers/FollowingWidget.dart';

class FollowingsList extends StatelessWidget {
  final int id;

  const FollowingsList({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DisplayFollowingBloc, DisplayFollowingsState>(
      listener: (context, state) {
        print("state");
        print(state);
        print("state");
      },
      builder: (context, state) {
        if (state is FollowingLoaded) {
          return ListView.builder(
              itemCount: state.followers.length,
              itemBuilder: (context, index) {
                return FollowingWidget(
                  model: state.followers[index],
                  id: id,
                );
              });
        } else if (state is FollowersLoading) {
          return FollowersShimmer();
        } else {
          return FollowersShimmer();
        }
      },
    );
  }
}
