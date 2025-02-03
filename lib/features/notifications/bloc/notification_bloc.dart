import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trend/features/notifications/domain/entities/notification.dart';
import 'package:trend/features/notifications/domain/usecases/fetch_notifications.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FetchNotificationsUseCase fetchNotificationsUseCase;

  /// Constructor to initialize the Bloc with the use case
  NotificationBloc({required this.fetchNotificationsUseCase})
      : super(NotificationInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
  }

  /// Event handler for fetching notifications
  Future<void> _onFetchNotifications(
    FetchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      emit(NotificationLoading()); // Emit loading state
      final notifications =
          await fetchNotificationsUseCase.call(); // Fetch notifications
      emit(NotificationLoaded(notifications)); // Emit loaded state with data
    } catch (error) {
      emit(NotificationError(
          'Failed to fetch notifications: $error')); // Emit error state
    }
  }
}
