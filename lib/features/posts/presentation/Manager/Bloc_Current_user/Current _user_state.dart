import 'package:trend/features/posts/data/models/post_model.dart';

abstract class CurrentuserState {}

class GetPostForCurrentUserLoading extends CurrentuserState {}

class GetPostForCurrentUserSuccess extends CurrentuserState {
  final List<PostModel> posts;
  GetPostForCurrentUserSuccess({required this.posts});
}

class GetPostForCurrentUserFailuer extends CurrentuserState {}

class GetPostForCurrentUserInit extends CurrentuserState {}
