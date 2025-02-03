abstract class UserEvent {}

class FetchUserEvent2 extends UserEvent {
  final int userId;

  FetchUserEvent2(this.userId);
}

class BlockUserEvent extends UserEvent {
  final int userId;

  BlockUserEvent(this.userId);
}

class FetchUserEventForUpdate extends UserEvent {
  final int userId;

  FetchUserEventForUpdate(this.userId);
}

class getpostForUser extends UserEvent {
  final int userId;

  getpostForUser(this.userId);
}
