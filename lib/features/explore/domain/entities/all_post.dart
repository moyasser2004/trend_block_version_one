import 'package:equatable/equatable.dart';

class AllPost extends Equatable {
  
  final String? next;
  final dynamic previous;
  final int? count;
  final List<Post> results;

  const AllPost({
    required this.next,
    required this.previous,
    required this.count,
    required this.results,
  });
  
  @override
  List<Object?> get props => [
        next,
        previous,
        count,
        results,
      ];
}


class Post extends Equatable {

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
  final List<dynamic> taggedUsers;
  final List<String> hashtagsData;
  
  const Post({
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
    required this.taggedUsers,
    required this.hashtagsData,
  });
  
  
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
        taggedUsers,
        hashtagsData,
      ];
}
