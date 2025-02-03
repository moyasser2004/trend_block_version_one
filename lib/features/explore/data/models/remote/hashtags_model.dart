import '../../../domain/entities/hashtags_search.dart';

class SearchHashtagsModel extends SearchHashtags {
  SearchHashtagsModel({required super.hashtags});

  factory SearchHashtagsModel.fromJson(Map<String, dynamic> json) {
    return SearchHashtagsModel(
      hashtags: json["hashtags"] == null
          ? []
          : List<Hashtag>.from(json["hashtags"]!
              .map((x) => HashtagsModel.fromJson(x))),
    );
  }
}

class HashtagsModel extends Hashtag {
  HashtagsModel(
      {required super.id,
      required super.name,
      required super.slug,
      required super.postsCount,
      required super.isTrending,
      required super.lastUsed,
      required super.createdAt});

  factory HashtagsModel.fromJson(Map<String, dynamic> json) {
    return HashtagsModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      postsCount: json["posts_count"],
      isTrending: json["is_trending"],
      lastUsed: DateTime.tryParse(json["last_used"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }
}
