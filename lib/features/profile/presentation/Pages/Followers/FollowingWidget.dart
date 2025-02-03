import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';
import 'package:trend/features/profile/data/models/FolloersModel.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_Following/State_Following.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_Following/bloc_folllowing.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_Following/event_Following.dart';
import 'package:trend/features/profile/presentation/Manager/Display_Following_bloc/followers_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/Display_Following_bloc/followers_event.dart';
import 'package:trend/features/profile/presentation/Manager/Display_followerBloc/followers_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/Display_followerBloc/followers_event.dart';

class FollowingWidget extends StatelessWidget {
  const FollowingWidget({super.key, required this.model, required this.id});
  final FollowerModel model;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            Networkimages(imageUrl: model.avatar, size: 30),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.username,
                    style: TextStyle(fontWeight: FontWeight.w400)),
                Text(
                  model.fullName,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 37,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    border: model.isFollowed
                        ? Border.all(width: 1, color: Colors.black)
                        : null,
                    color: model.isFollowed ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: model.isFollowed
                    ? Center(
                        child: Text(
                        "Message",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ))
                    : Center(
                        child: Text(
                        "Follow back",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      )),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            BlocConsumer<FollowingBloc, FollowingState>(
              listener: (context, state) {
                if (state is UnFollowingSuccess) {
                  BlocProvider.of<FollowersBloc>(context)
                      .add(LoadFollowers(id: id));

                  BlocProvider.of<DisplayFollowingBloc>(context)
                      .add(LoadFollowing1(id: id));
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<FollowingBloc>(context)
                        .add(UnFollowUserEvent(model.id));
                  },
                  child: Text(
                    "x",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
