import 'package:equatable/equatable.dart';

class SearchHashtags extends Equatable {
  final List<Hashtag> hashtags;

  const SearchHashtags({
    required this.hashtags,
  });
  

  @override
  List<Object?> get props => [
        hashtags,
      ];
}

class Hashtag extends Equatable {
  final int? id;
  final String? name;
  final String? slug;
  final int? postsCount;
  final bool? isTrending;
  final DateTime? lastUsed;
  final DateTime? createdAt;

  Hashtag({
    required this.id,
    required this.name,
    required this.slug,
    required this.postsCount,
    required this.isTrending,
    required this.lastUsed,
    required this.createdAt,
  });



  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        postsCount,
        isTrending,
        lastUsed,
        createdAt,
      ];
}
