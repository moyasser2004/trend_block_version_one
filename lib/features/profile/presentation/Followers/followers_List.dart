import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/All_Bloc/Display_followerBloc/followers_bloc.dart';
import 'package:trend/features/profile/All_Bloc/Display_followerBloc/followers_state.dart';
import 'package:trend/features/profile/presentation/Followers/FollowerWidget.dart';

class FollowersList extends StatelessWidget {
  final int id;

  const FollowersList({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowersBloc, FollowersState>(
      listener: (context, state) {
        print(state);
        print("====================================dfdf");
      },
      builder: (context, state) {
        // List<FollowerModel> list =
        //     BlocProvider.of<FollowersBloc>(context).ListFollower;
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
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text("Error "),
          );
        }
      },
    );
  }
}
