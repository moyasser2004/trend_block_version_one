import 'package:trend/features/posts/data/models/post_model.dart';

sealed class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  bool createCommentLoading;
  bool isLikeLoading;
  final List<PostModel> posts;

  PostLoaded(this.posts,
      {this.isLikeLoading = false, this.createCommentLoading = false});
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}

class CommentsLoading extends PostState {}

class CommentsLoaded extends PostState {
  final List<Comment> comments;

  CommentsLoaded(this.comments);
}

class CommentsError extends PostState {
  final String message;

  CommentsError(this.message);
}

class getPostForSpecificUserSuccess extends PostState {
  final List<PostModel> posts;

  getPostForSpecificUserSuccess({required this.posts});
}

class getPostForSpecificUserFailuer extends PostState {}

class getPostForSpecificUserLoading extends PostState {}
