import 'package:trend/features/posts/data/models/LikedUserModel.dart';

class Comment {
  int? id;
  int? post;
  String? author;
  int? authorId;
  String? content;
  bool? isLiked;
  String? createdAt;
  String? updatedAt;
  int? likesCount;
  int? repliesCount;
  List<LikedUsers>? likedUsers;
  int? commentOnComment;
  List<Comment>? replies;

  Comment(
      {this.id,
      this.post,
      this.author,
      this.authorId,
      this.content,
      this.isLiked,
      this.createdAt,
      this.updatedAt,
      this.likesCount,
      this.repliesCount,
      this.likedUsers,
      this.commentOnComment,
      this.replies});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'];
    author = json['author'];
    authorId = json['author_id'];
    content = json['content'];
    isLiked = json['is_liked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    repliesCount = json['replies_count'];
    if (json['liked_users'] != null) {
      likedUsers = <LikedUsers>[];
      json['liked_users'].forEach((v) {
        likedUsers!.add(new LikedUsers.fromJson(v));
      });
    }
    commentOnComment = json['comment_on_comment'];
    if (json['replies'] != null) {
      replies = <Comment>[];
      json['replies'].forEach((v) {
        replies!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post'] = this.post;
    data['author'] = this.author;
    data['author_id'] = this.authorId;
    data['content'] = this.content;
    data['is_liked'] = this.isLiked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['replies_count'] = this.repliesCount;
    if (this.likedUsers != null) {
      data['liked_users'] = this.likedUsers!.map((v) => v.toJson()).toList();
    }
    data['comment_on_comment'] = this.commentOnComment;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
