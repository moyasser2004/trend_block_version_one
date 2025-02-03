part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

/// Initial state before any action
final class NotificationInitial extends NotificationState {}

/// Loading state when notifications are being fetched
final class NotificationLoading extends NotificationState {}

/// Loaded state when notifications are successfully fetched
final class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications; // List of notifications

  NotificationLoaded(this.notifications);
}

/// Error state when something goes wrong while fetching notifications
final class NotificationError extends NotificationState {
  final String errorMessage; // Error message

  NotificationError(this.errorMessage);
}
