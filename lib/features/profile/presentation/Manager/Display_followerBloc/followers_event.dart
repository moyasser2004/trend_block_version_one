// Bloc Events

abstract class FollowersEvent {}

class LoadFollowers extends FollowersEvent {
  final int id;
  LoadFollowers({required this.id});
}

class refreshList extends FollowersEvent {}
