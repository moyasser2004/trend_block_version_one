class FollowerModel {
  final int id;
  final String username;
  final String fullName;
  final String? bio;
  final String? location;
  final String? birthDate;
  final bool verified;
  final bool isPrivate;
  final int followersCount;
  final int followingCount;
  final int totalPosts;
  final String createdAt;
  final String updatedAt;
  final bool isBlocked;
  bool isFollowed;
  final bool isFollowing;
  final String avatar;
  final int totalLikes;

  FollowerModel({
    required this.id,
    required this.username,
    required this.fullName,
    this.bio,
    this.location,
    this.birthDate,
    required this.verified,
    required this.isPrivate,
    required this.followersCount,
    required this.followingCount,
    required this.totalPosts,
    required this.createdAt,
    required this.updatedAt,
    required this.isBlocked,
    required this.isFollowed,
    required this.isFollowing,
    required this.avatar,
    required this.totalLikes,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowerModel(
      id: json['id'],
      username: json['user'],
      fullName: json['full_name'],
      bio: json['bio'],
      location: json['location'],
      birthDate: json['birth_date'],
      verified: json['verified'],
      isPrivate: json['is_private'],
      followersCount: json['followers'],
      followingCount: json['following'],
      totalPosts: json['total_posts'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isBlocked: json['is_blocked'],
      isFollowed: json['is_followed'],
      isFollowing: json['is_following'],
      avatar: json['avatar'],
      totalLikes: json['total_likes'],
    );
  }
}
