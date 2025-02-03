abstract class FollowingEvent {}

class FollowUserEvent extends FollowingEvent {
  final int userId;

  FollowUserEvent(this.userId);
}

class UnFollowUserEvent extends FollowingEvent {
  final int userId;

  UnFollowUserEvent(this.userId);
}
