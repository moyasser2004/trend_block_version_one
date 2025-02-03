// Bloc States
import 'package:trend/features/profile/data/models/FolloersModel.dart';

abstract class FollowersState {}

class FollowersInitial extends FollowersState {}

class FollowersLoading extends FollowersState {}

class FollowersLoaded extends FollowersState {
  final List<FollowerModel> followers;
  FollowersLoaded(this.followers);
}

class FollowersError extends FollowersState {
  final String message;
  FollowersError(this.message);
}
