import 'package:dio/dio.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/notifications/domain/entities/notification.dart';

import '../../../../shared/const/app_links.dart';

class NotificationRepository {
  final Dio dio; // Dio instance for making requests

  /// Constructor to initialize the repository with Dio.
  NotificationRepository({required this.dio});

  /// Fetches all notifications from the API.
  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      String? tok = await token.getToken();
      final response = await dio.get(
        ApiEndpoints.allNotifications(0),
        options: Options(
          headers: {'Authorization': 'Bearer $tok'}, // Ensure token is included
        ),
      );
      // Check if the response is successful
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final notificationsJson = data['notifications'] as List<dynamic>;

        List<NotificationModel> notifications = notificationsJson
            .map((json) =>
                NotificationModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return notifications;
      } else {
        throw Exception(
            'Failed to fetch notifications. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }
}
