import 'package:flutter/material.dart';
import 'package:trend/features/notifications/domain/entities/notification.dart';
import 'package:trend/features/notifications/presentation/pages/Widget/Avatar.dart';
import 'package:trend/features/notifications/presentation/pages/Widget/NotificationContent.dart';

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
          NotificationAvatar(
            notification: notification,
          ),
          SizedBox(width: 10),
          Notificationcontent(
            notification: notification,
          )
        ],
      ),
    );
  }
}
