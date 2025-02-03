import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/State_Following.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/bloc_folllowing.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/event_Following.dart';
import 'package:trend/features/profile/All_Bloc/Display_Following_bloc/followers_bloc.dart';
import 'package:trend/features/profile/All_Bloc/Display_Following_bloc/followers_event.dart';
import 'package:trend/features/profile/All_Bloc/Display_followerBloc/followers_bloc.dart';
import 'package:trend/features/profile/All_Bloc/Display_followerBloc/followers_event.dart';
import 'package:trend/features/profile/data/models/FolloersModel.dart';

class FollowerWidget extends StatefulWidget {
  const FollowerWidget({super.key, required this.model, required this.id});
  final FollowerModel model;
  final int id;

  @override
  State<FollowerWidget> createState() => _FollowerWidgetState();
}

class _FollowerWidgetState extends State<FollowerWidget> {
  @override
  Widget build(BuildContext context) {
    bool followed = widget.model.isFollowed;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            Networkimages(imageUrl: widget.model.avatar, size: 30),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.model.username,
                    style: TextStyle(fontWeight: FontWeight.w400)),
                Text(
                  widget.model.fullName,
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
            BlocConsumer<FollowingBloc, FollowingState>(
              listener: (context, state) {
                if (state is FollowingSuccess) {
                  BlocProvider.of<FollowersBloc>(context)
                      .add(LoadFollowers(id: widget.id));

                  BlocProvider.of<DisplayFollowingBloc>(context)
                      .add(LoadFollowing1(id: widget.id));
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (!followed) {
                      BlocProvider.of<FollowingBloc>(context)
                          .add(FollowUserEvent(widget.model.id));
                    }
                  },
                  child: Container(
                    height: 37,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        border: followed
                            ? Border.all(width: 1, color: Colors.black)
                            : null,
                        color: followed ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: followed
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
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "x",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                    color: Colors.grey),
              ),
            ),
          ],
        ));
  }
}
