abstract class FollowingbackEvent {}

class FollowbackUserEvent extends FollowingbackEvent {
  final int userId;
  final int index;
  FollowbackUserEvent(this.userId, this.index);
}

// class UnFollowbackUserEvent extends FollowingbackEvent {
//   final int userId;

//   UnFollowbackUserEvent(this.userId);
// }
