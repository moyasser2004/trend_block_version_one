// Bloc States
import 'package:trend/features/profile/data/models/FolloersModel.dart';

abstract class DisplayFollowingsState {}

class FollowingsInitial extends DisplayFollowingsState {}

class FollowingLoading extends DisplayFollowingsState {}

class FollowingLoaded extends DisplayFollowingsState {
  final List<FollowerModel> followers;
  FollowingLoaded(this.followers);
}

class FollowingError extends DisplayFollowingsState {
  final String message;
  FollowingError(this.message);
}
