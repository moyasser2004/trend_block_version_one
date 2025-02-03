// Bloc Events

abstract class DisplayFollowingEvent {}

class LoadFollowing1 extends DisplayFollowingEvent {
  final int id;
  LoadFollowing1({required this.id});
}
