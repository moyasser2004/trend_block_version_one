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

class LikedUsers {
  int? id;
  String? username;

  LikedUsers({this.id, this.username});

  LikedUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}
