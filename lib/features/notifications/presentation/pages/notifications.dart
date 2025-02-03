import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/notifications/presentation/Manager/NotificationBloc/notification_bloc.dart';
import 'package:trend/features/notifications/presentation/pages/Widget/LotificationList.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<bool> isFollowing = []; // حالة زر المتابعة لكل إشعار

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('No notifications available.'));
            }

            if (isFollowing.length != state.notifications.length) {
              isFollowing =
                  List.generate(state.notifications.length, (index) => false);
            }
            return NotificationList(notifications: state.notifications);
          } else if (state is NotificationError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text('No notifications available.'));
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
