class NotificationModel {
  final int id;
  final String recipient;
  final String actor;
  final String verb;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.recipient,
    required this.actor,
    required this.verb,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      recipient: json['recipient'] as String,
      actor: json['actor'] as String,
      verb: json['verb'] as String,
      isRead: json['is_read'] as bool,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipient': recipient,
      'actor': actor,
      'verb': verb,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
