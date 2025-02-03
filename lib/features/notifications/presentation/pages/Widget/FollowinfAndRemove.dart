import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/notifications/domain/entities/notification.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_Following/State_Following.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_Following/bloc_folllowing.dart';

class Followinfandremove extends StatelessWidget {
  const Followinfandremove({super.key, required this.notification, this.onTap});
  final void Function()? onTap;
  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: BlocListener<FollowingBloc, FollowingState>(
            listener: (context, state) {
              if (state is FollowingSuccess || state is FollowingSuccess) {}
            },
            child: Container(
              height: 34,
              width: 112,
              decoration: BoxDecoration(
                  color: Color(0xff000000),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  "Follow Back",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 34,
            width: 103,
            decoration: BoxDecoration(
                color: Color(0xffF9F9FC),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                "Remove",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
