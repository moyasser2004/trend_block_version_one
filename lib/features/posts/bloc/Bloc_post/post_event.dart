import 'package:flutter/material.dart';
import 'package:trend/features/posts/data/models/post_model.dart';

@immutable
sealed class PostEvent {}

class FetchPosts extends PostEvent {}

class LikePost extends PostEvent {
  final int postId;
  LikePost({required this.postId});
}

class AddComment extends PostEvent {
  final int postId;
  final String content;
  AddComment({required this.postId, required this.content});
}

class LikeComment extends PostEvent {
  final int postId;
  final int commentId;
  final int? subCommentId;
  LikeComment(
      {required this.commentId, required this.postId, this.subCommentId});
}

class LikeCommentoncomment extends PostEvent {
  final int subCommentId;
  LikeCommentoncomment({required this.subCommentId});
}

class AddCommentOnComment extends PostEvent {
  final int postId;
  final int commentId;
  final String content;

  AddCommentOnComment(
      {required this.postId, required this.commentId, required this.content});
}

// New event for adding a post
class AddPostEvent extends PostEvent {
  final PostModel post; // The new post to be added

  AddPostEvent(this.post);
}

class AddBlocUserEvent extends PostEvent {
  final int userId; // The new post to be added

  AddBlocUserEvent(this.userId);
}

class AddDeletePostEvent extends PostEvent {
  final int postId; // The new post to be added

  AddDeletePostEvent(this.postId);
}

class getPostForSpecificUser extends PostEvent {
  final int id;

  getPostForSpecificUser({required this.id});
}

class GotoDisplayPostEvent extends PostEvent {
  final List<PostModel> posts;
  final BuildContext context;
  final int x;

  GotoDisplayPostEvent(
      {required this.posts, required this.context, required this.x});
}
