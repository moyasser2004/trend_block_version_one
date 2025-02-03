import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/Display_followerBloc/followers_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/Display_followerBloc/followers_state.dart';
import 'package:trend/features/profile/presentation/Pages/Followers/FollowerWidget.dart';
import 'package:trend/features/profile/presentation/Pages/Followers/FollowersShimmer.dart';

class FollowersList extends StatelessWidget {
  final int id;

  const FollowersList({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowersBloc, FollowersState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FollowersLoaded) {
          return ListView.builder(
              itemCount: state.followers.length,
              itemBuilder: (context, index) {
                return FollowerWidget(
                  model: state.followers[index],
                  id: id,
                );
              });
        } else if (state is FollowersLoading) {
          return FollowersShimmer();
        } else {
          return Center(
            child: Text(" Error "),
          );
        }
      },
    );
  }
}
