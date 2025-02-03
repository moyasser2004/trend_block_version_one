import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/notifications/bloc/FollowBack/FollowBackBloc.dart';
import 'package:trend/features/notifications/domain/entities/notification.dart';
import 'package:trend/features/notifications/presentation/Notificatioitem.dart';
import 'package:trend/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key, required this.notifications});
  final List<NotificationModel> notifications;

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.notifications.length,
      itemBuilder: (context, index) {
        final notification = widget.notifications[index];
        return BlocProvider(
          create: (context) => FollowingbackBloc(
              Dio(), ProfileRepository(ProfileRemoteDatasource(Dio()))),
          child: NotificationItem(notification: notification),
        );
      },
    );
  }
}
