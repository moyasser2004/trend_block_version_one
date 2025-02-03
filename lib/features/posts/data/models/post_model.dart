import 'package:trend/features/posts/data/models/CommentModel.dart';

class PostModel {
  int? id;
  String? author;
  int? authorId;
  String? avatar;
  String? description;
  String? image;
  bool? isLiked;
  late DateTime createdAt;
  late DateTime updatedAt;
  int? likesCount;
  int? commentsCount;
  int? sharesCount;
  int? viewsCount;
  bool? isPublic;
  bool? allowComments;
  List<Comment>? comments;

  PostModel(
      {this.id,
      this.author,
      this.authorId,
      this.avatar,
      this.description,
      this.image,
      this.isLiked,
      this.likesCount,
      this.commentsCount,
      this.sharesCount,
      this.viewsCount,
      this.isPublic,
      this.allowComments,
      this.comments});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    authorId = json['author_id'];
    avatar = json['avatar'];
    description = json['description'];
    image = json['image'];
    isLiked = json['is_liked'];
    createdAt = DateTime.parse(json['created_at'] ?? '');
    updatedAt = DateTime.parse(json['updated_at'] ?? '');
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    sharesCount = json['shares_count'];
    viewsCount = json['views_count'];
    isPublic = json['is_public'];
    allowComments = json['allow_comments'];

    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['author_id'] = this.authorId;
    data['avatar'] = this.avatar;
    data['description'] = this.description;
    data['image'] = this.image;
    data['is_liked'] = this.isLiked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    data['shares_count'] = this.sharesCount;
    data['views_count'] = this.viewsCount;
    data['is_public'] = this.isPublic;
    data['allow_comments'] = this.allowComments;

    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
