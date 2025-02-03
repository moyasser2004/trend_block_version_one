import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/notifications/bloc/FollowBack/FollowBackBloc.dart';
import 'package:trend/features/notifications/bloc/FollowBack/FollowBackState.dart';
import 'package:trend/features/notifications/bloc/FollowBack/FollowBackevent.dart';
import 'package:trend/features/notifications/domain/entities/notification.dart';
import 'package:trend/features/notifications/presentation/actorandtime.dart';
import 'package:trend/features/notifications/presentation/notificatioVerb.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/bloc_get.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/event_getU.dart';

import '../../../shared/utiles/routes.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<UserBloc>(context).add(
                  FetchUserEvent2(notification.id_actor),
                );
                Navigator.pushNamed(context, AppRoutes.userProfile);
              },
              child: ClipOval(
                child: Networkimages(
                  imageUrl: notification.avatar,
                  size: 50.r,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Actorandtime(
                Actor: notification.actor,
                createdAt: notification.createdAt,
              ),
              Notificatioverb(
                verb: notification.verb,
              ),
              SizedBox(height: 5),
              if (notification.verb.contains("following you"))
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<FollowingbackBloc>(context).add(
                          FollowbackUserEvent(
                              notification.id_actor, notification.id_actor),
                        );
                      },
                      child: BlocBuilder<FollowingbackBloc, FollowingbackState>(
                        builder: (context, state) {
                          if (state is FollowingBackSuccess) {
                            return _buildFollowingButton();
                          } else if (state is FollowingBackLoadding) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          } else {
                            return _buildFollowBackButton();
                          }
                        },
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
          ),
        ],
      ),
    );
  }
}

Widget _buildFollowingButton() {
  return Container(
    height: 34,
    width: 112,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Center(
      child: Text(
        "Following",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

Widget _buildFollowBackButton() {
  return Container(
    height: 34,
    width: 112,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Center(
      child: Text(
        "Follow Back",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
