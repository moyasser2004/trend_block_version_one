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
  List<Object?> get props =>
      [
        count, next, previous, results,
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
  List<Object?> get props =>
      [
        metadata, users,
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
  List<Object?> get props =>
      [
        totalCount, query, postsLimit,
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
  List<Object?> get props =>
      [
        id, username, email, fullName, avatar, recentPosts,
      ];
}

class RecentPost extends Equatable {
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
  });

  final int? id;
  final String? author;
  final int? authorId;
  final String? avatar;
  final String? description;
  final dynamic image;
  final bool? isLiked;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? likesCount;
  final int? commentsCount;
  final int? sharesCount;
  final int? viewsCount;
  final bool? isPublic;
  final bool? allowComments;

  

  @override
  List<Object?> get props =>
      [
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
      ];
}

