import '../../../domain/entities/all_post.dart';

class AllPostModel extends AllPost {
  AllPostModel(
      {required super.next,
      required super.previous,
      required super.count,
      required super.results});

  factory AllPostModel.fromJson(Map<String, dynamic> json) {
    return AllPostModel(
      next: json["next"],
      previous: json["previous"],
      count: json["count"],
      results: json["results"] == null
          ? []
          : List<Post>.from(
              json["results"]!.map((x) => PostModel.fromJson(x))),
    );
  }
}

class PostModel extends Post {
  PostModel(
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
      required super.taggedUsers,
      required super.hashtagsData});


  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      author: json["author"],
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
      taggedUsers: json["tagged_users"] == null
          ? []
          : List<dynamic>.from(json["tagged_users"]!.map((x) => x)),
      hashtagsData: json["hashtags_data"] == null
          ? []
          : List<String>.from(json["hashtags_data"]!.map((x) => x)),
    );
  }

}
