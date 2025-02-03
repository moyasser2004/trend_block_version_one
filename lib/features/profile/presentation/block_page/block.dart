import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_bloc.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_state.dart';
import 'package:trend/features/profile/presentation/block_page/BlocList.dart';

class BlockedUsers extends StatelessWidget {
  const BlockedUsers({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Blocked Users',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is getBlockedUserLoaded) {}
          },
          builder: (context, state) {
            if (state is getBlockedUserLoaded) {
              return Bloclist(
                id: id,
                posts: state.posts,
              );
            } else if (state is getBlockedUserLoading) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return Text("Error");
            }
          },
        ));
  }
}
