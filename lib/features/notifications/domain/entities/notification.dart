/// Core Notification Entity
class NotificationModel {
  final int id; // Unique identifier for the notification
  final String target; // The user receiving the notification
  final String actor; // The user who performed the action
  final String verb; // Action performed (e.g., "liked your post")
  final bool is_read; // Indicates whether the notification has been read
  final DateTime createdAt; // Time when the notification was created
  final String avatar;
  final int id_actor;
  NotificationModel(
      {required this.id,
      required this.target,
      required this.actor,
      required this.verb,
      required this.id_actor,
      required this.is_read,
      required this.createdAt,
      required this.avatar});

  /// Factory method to map NotificationModel to Notification
  /// (Optional: Keep this in the data layer to maintain domain independence)
  factory NotificationModel.fromModel(NotificationModel model) {
    return NotificationModel(
      id: model.id,
      target: model.target,
      actor: model.actor,
      verb: model.verb,
      is_read: model.is_read,
      createdAt: model.createdAt,
      id_actor: model.id_actor,
      avatar: model.avatar,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      actor: json['actor'] ?? "actor",
      verb: json['verb'] ?? "actor",
      target: json['target'] ?? "actor",
      is_read: json['is_read'] ?? "actor",
      avatar: json['avatar'] ?? "actor",
      id_actor: json['id_actor'],
      createdAt: DateTime.parse(json['created_at']) ?? DateTime.now(),
    );
  }
}
