import 'package:equatable/equatable.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';

/// Base class for all Profile-related states.
abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state when no action has been performed.
class ProfileInitial extends ProfileState {}

/// State when the profile is being loaded.
class ProfileLoading extends ProfileState {}

/// State when the profile is successfully loaded.
class ProfileLoaded extends ProfileState {
  final ProfileModel profile; // Non-nullable for simplicity

  ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// State when there is an error loading the profile.
class ProfileError extends ProfileState {
  final String message;

  ProfileError([this.message = "An unknown error occurred"]);

  @override
  List<Object?> get props => [message];
}

class getPostForspecificUser extends ProfileState {
  final List<PostModel> posts;
  getPostForspecificUser({required this.posts});
}

class getPostForspecificUserLoading extends ProfileState {}

class getBlockedUserLoading extends ProfileState {}

class getBlockedUserLoaded extends ProfileState {
  List<ProfileModel> posts;
  getBlockedUserLoaded({required this.posts});
}

class getBlockedUserFailuer extends ProfileState {}

class Logoutsuccess extends ProfileState {}

class LogoutLoading extends ProfileState {}

class LogoutFailuer extends ProfileState {}

class Deletesuccess extends ProfileState {}

class DeleteLoading extends ProfileState {}

class DeleteFailuer extends ProfileState {}

class Updatesuccess extends ProfileState {
  final String avatar;
  final String bio;
  final String full_name;
  Updatesuccess(this.avatar, this.bio, this.full_name);
}

class UpdateLoading extends ProfileState {}

class UpdateFailuer extends ProfileState {}
