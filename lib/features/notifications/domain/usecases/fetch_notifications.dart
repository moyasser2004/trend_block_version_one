import '../../data/repositories/notification_repository.dart';
import '../entities/notification.dart' as app_entity;

class FetchNotificationsUseCase {
  final NotificationRepository repository;

  FetchNotificationsUseCase({required this.repository});

  Future<List<app_entity.NotificationModel>> call() async {
    try {
      final notifications = await repository.fetchNotifications();
      return notifications
          .map((model) => app_entity.NotificationModel.fromModel(model))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }
}
