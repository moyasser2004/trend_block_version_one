import '../../../domain/entities/for_you_search.dart';

class PostSearchModel extends PostSearch {
  PostSearchModel(
      {required super.count,
      required super.next,
      required super.previous,
      required super.results});

  factory PostSearchModel.fromJson(Map<String, dynamic> json) {
    return PostSearchModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] == null
          ? null
          : ResultsModel.fromJson(json["results"]),
    );
  }
}

class ResultsModel extends Results {
  ResultsModel({required super.metadata, required super.users});

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    return ResultsModel(
      metadata: json["metadata"] == null
          ? null
          : MetadataModel.fromJson(json["metadata"]),
      users: json["users"] == null
          ? []
          : List<User>.from(
              json["users"]!.map((x) => UserModel.fromJson(x))),
    );
  }
}

class MetadataModel extends Metadata {
  MetadataModel(
      {required super.totalCount,
      required super.query,
      required super.postsLimit});

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      totalCount: json["total_count"],
      query: json["query"],
      postsLimit: json["posts_limit"],
    );
  }
}

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.username,
      required super.email,
      required super.fullName,
      required super.avatar,
      required super.recentPosts});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      fullName: json["full_name"],
      avatar: json["avatar"],
      recentPosts: json["recent_posts"] == null
          ? []
          : List<RecentPost>.from(json["recent_posts"]!
              .map((x) => RecentPostModel.fromJson(x))),
    );
  }
}

class RecentPostModel extends RecentPost {
  RecentPostModel(
      {required super.id,
      required super.author,
      required super.authorId,
      required super.avatar,
      required super.description,
      required super.image,
      required super.isLiked,
      required super.createdAt,
      required super.updatedAt,
      required super.likesCount,
      required super.commentsCount,
      required super.sharesCount,
      required super.viewsCount,
      required super.isPublic,
      required super.allowComments,
      required super.comments});

  factory RecentPostModel.fromJson(Map<String, dynamic> json) {
    return RecentPostModel(
      author: json["author"],
      id: json["id"],
      authorId: json["author_id"],
      avatar: json["avatar"],
      description: json["description"],
      image: json["image"],
      isLiked: json["is_liked"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      likesCount: json["likes_count"],
      commentsCount: json["comments_count"],
      sharesCount: json["shares_count"],
      viewsCount: json["views_count"],
      isPublic: json["is_public"],
      allowComments: json["allow_comments"],
      comments: [],
    );
  }
}

class CommentModel extends Comment {
  CommentModel(
      {required super.id,
      required super.post,
      required super.author,
      required super.authorId,
      required super.content,
      required super.isLiked,
      required super.createdAt,
      required super.updatedAt,
      required super.likesCount,
      required super.repliesCount,
      required super.likedUsers,
      required super.commentOnComment,
      required super.replies});

  factory CommentModel.fromJson(Map<String, dynamic> json){
    return CommentModel(
      id: json["id"],
      post: json["post"],
      author: json["author"],
      authorId: json["author_id"],
      content: json["content"],
      isLiked: json["is_liked"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      likesCount: json["likes_count"],
      repliesCount: json["replies_count"],
      likedUsers: json["liked_users"] == null ? [] : List<LikedUser>.from(json["liked_users"]!.map((x) => LikedUserModel.fromJson(x))),
      commentOnComment: json["comment_on_comment"],
      replies: json["replies"] == null ? [] : List<Comment>.from(json["replies"]!.map((x) => CommentModel.fromJson(x))),
    );
  }
  
  
}


class LikedUserModel extends LikedUser {
  LikedUserModel({required super.id, required super.username});


  factory LikedUserModel.fromJson(Map<String, dynamic> json){
    return LikedUserModel(
      id: json["id"],
      username: json["username"],
    );
  }


}