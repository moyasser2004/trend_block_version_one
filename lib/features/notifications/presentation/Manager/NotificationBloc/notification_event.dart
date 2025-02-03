part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

/// Event to fetch notifications
class FetchNotificationsEvent extends NotificationEvent {}
