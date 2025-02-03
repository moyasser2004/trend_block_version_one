import 'dart:io';

abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {
  final int id;
  FetchProfileEvent({required this.id});
}

// class FollowUserEvent extends ProfileEvent {
//   final int id;
//   FollowUserEvent({required this.id});
// }

// class UnfollowUserEvent extends ProfileEvent {
//   final int id;
//   UnfollowUserEvent({required this.id});
// }

class FetchUserEvent extends ProfileEvent {
  final int id;
  FetchUserEvent({required this.id});
}

class getPostForUserevent extends ProfileEvent {
  final int id;
  getPostForUserevent({required this.id});
}

class getBlockedUser extends ProfileEvent {
  final int id;
  getBlockedUser({required this.id});
}

class Logout extends ProfileEvent {}

class Delete extends ProfileEvent {}

class UpdateAvatar extends ProfileEvent {
  final int id;
  final File image;
  UpdateAvatar(this.id, this.image);
}

class Updatefullname extends ProfileEvent {
  final int id;
  final String full_name;
  Updatefullname(this.id, this.full_name);
}

class Updatebio extends ProfileEvent {
  final int id;
  final String? bio;
  Updatebio(this.id, this.bio);
}

class Accountprivacy extends ProfileEvent {
  final bool private;
  final int id;
  Accountprivacy({required this.private, required this.id});
}
