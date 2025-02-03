import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';

abstract class UserState {}

abstract class UserpostsState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final ProfileModel user;

  UserLoadedState(this.user);
}

class UserErrorState extends UserState {
  final String errorMessage;

  UserErrorState(this.errorMessage);
}

class GetPOstForUserInitial extends UserpostsState {}

class UserBlockedState extends UserpostsState {}

class getPostLOading extends UserpostsState {}

class getPostSuccess extends UserpostsState {
  final List<PostModel> posts;
  getPostSuccess({required this.posts});
}

class getPostFailuer extends UserpostsState {}
