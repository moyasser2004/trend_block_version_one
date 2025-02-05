import 'dart:convert';

import 'package:equatable/equatable.dart';

class PostSearch extends Equatable {
  final int? count;
  final String? next;
  final dynamic previous;
  final Results? results;

  const PostSearch({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}

class Results extends Equatable {
  final Metadata? metadata;
  final List<User> users;

  Results({
    required this.metadata,
    required this.users,
  });

  @override
  List<Object?> get props => [
        metadata,
        users,
      ];
}

class Metadata extends Equatable {
  final int? totalCount;
  final String? query;
  final int? postsLimit;

  Metadata({
    required this.totalCount,
    required this.query,
    required this.postsLimit,
  });

  @override
  List<Object?> get props => [
        totalCount,
        query,
        postsLimit,
      ];
}

class User extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? fullName;
  final String? avatar;
  final List<RecentPost> recentPosts;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.avatar,
    required this.recentPosts,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        avatar,
        recentPosts,
      ];
}

class RecentPost extends Equatable {
  final int? id;
  final String? author;
  final int? authorId;
  final String? avatar;
  final String? description;
  final String? image;
  final bool? isLiked;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? likesCount;
  final int? commentsCount;
  final int? sharesCount;
  final int? viewsCount;
  final bool? isPublic;
  final bool? allowComments;
  final List<Comment>? comments;

  RecentPost({
    required this.id,
    required this.author,
    required this.authorId,
    required this.avatar,
    required this.description,
    required this.image,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.viewsCount,
    required this.isPublic,
    required this.allowComments,
    required this.comments,
  });


  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "author": this.author,
      "authorId": this.authorId,
      "avatar": this.avatar,
      "description": this.description,
      "image": this.image,
      "isLiked": this.isLiked,
      "createdAt": this.createdAt?.toIso8601String(),
      "updatedAt": this.updatedAt?.toIso8601String(),
      "likesCount": this.likesCount,
      "commentsCount": this.commentsCount,
      "sharesCount": this.sharesCount,
      "viewsCount": this.viewsCount,
      "isPublic": this.isPublic,
      "allowComments": this.allowComments,
      "comments": jsonEncode(this.comments),
    };
  }

  @override
  List<Object?> get props => [
        id,
        author,
        authorId,
        avatar,
        description,
        image,
        isLiked,
        createdAt,
        updatedAt,
        likesCount,
        commentsCount,
        sharesCount,
        viewsCount,
        isPublic,
        allowComments,
        comments,
      ];
}

class Comment extends Equatable {
  final int? id;
  final int? post;
  final String? author;
  final int? authorId;
  final String? content;
  final bool? isLiked;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? likesCount;
  final int? repliesCount;
  final List<LikedUser>? likedUsers;
  final int? commentOnComment;
  final List<Comment>? replies;

  Comment({
    required this.id,
    required this.post,
    required this.author,
    required this.authorId,
    required this.content,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.repliesCount,
    required this.likedUsers,
    required this.commentOnComment,
    required this.replies,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        post,
        author,
        authorId,
        content,
        isLiked,
        createdAt,
        updatedAt,
        likesCount,
        repliesCount,
        likedUsers,
        commentOnComment,
        replies,
      ];
}

class LikedUser extends Equatable {
  final int? id;
  final String? username;

  LikedUser({
    required this.id,
    required this.username,
  });

  @override
  List<Object?> get props => [
        id,
        username,
      ];
}
