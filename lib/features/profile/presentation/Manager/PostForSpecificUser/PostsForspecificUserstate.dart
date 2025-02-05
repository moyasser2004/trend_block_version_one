import 'package:trend/features/explore/data/models/remote/get_all_post_model.dart';

abstract class PostforuserState {}

class InitialPostState extends PostforuserState {}

class LoadingUserPostsState extends PostforuserState {}

class LoadedUserPostsState extends PostforuserState {
  final List<PostModel> posts;

  LoadedUserPostsState({required this.posts});
}

class ErrorUserPostsState extends PostforuserState {
  final String message;

  ErrorUserPostsState({required this.message});
}
