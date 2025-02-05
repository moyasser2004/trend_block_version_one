import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/notifications/domain/entities/notification.dart';
import 'package:trend/features/notifications/presentation/Manager/FollowBack/FollowBackBloc.dart';
import 'package:trend/features/notifications/presentation/Manager/FollowBack/FollowBackState.dart';
import 'package:trend/features/notifications/presentation/Manager/FollowBack/FollowBackevent.dart';
import 'package:trend/features/notifications/presentation/pages/Widget/ButtonsFollowing.dart';
import 'package:trend/features/notifications/presentation/pages/Widget/actorandtime.dart';
import 'package:trend/features/notifications/presentation/pages/Widget/notificatioVerb.dart';

class Notificationcontent extends StatefulWidget {
  const Notificationcontent({super.key, required this.notification});
  final NotificationModel notification;

  @override
  State<Notificationcontent> createState() => _NotificationcontentState();
}

class _NotificationcontentState extends State<Notificationcontent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Actorandtime(
          Actor: widget.notification.actor,
          createdAt: widget.notification.createdAt,
        ),
        Notificatioverb(
          verb: widget.notification.verb,
        ),
        SizedBox(height: 5),
        if (widget.notification.verb.contains("following you"))
          Row(
            children: [
              Visibility(
                visible: !widget.notification.is_following,
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<FollowingbackBloc>(context).add(
                      FollowbackUserEvent(widget.notification.id_actor,
                          widget.notification.id_actor),
                    );
                  },
                  child: BlocBuilder<FollowingbackBloc, FollowingbackState>(
                    builder: (context, state) {
                      if (state is FollowingBackSuccess) {
                        return Text(""); //add messanger button
                      } else if (state is FollowingBackLoadding) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else {
                        return Buttonsfollowing.buildFollowBackButton();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 34,
                  width: 112,
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9FC),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      "Remove",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
      ],
    );
  }
}
