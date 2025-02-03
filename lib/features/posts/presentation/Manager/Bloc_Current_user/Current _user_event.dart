abstract class CurrentUserEvent {}

class GetPostForCurrentUserEvent extends CurrentUserEvent {
  final int id;

  GetPostForCurrentUserEvent({required this.id});
}
