class ProfileModel {
  final int id;
  final String user;
  final String fullName;
  final String bio;
  final String? location;
  final String birthDate;
  final bool verified;
  final bool isPrivate;
  final int totalLikes;
  final int followers;
  final int following;
  final int totalPosts;
  final String createdAt;
  final String updatedAt;
  final bool isBlocked;
  final bool isFollowed;
  final bool isFollowing;
  final String avatar;

  ProfileModel({
    required this.id,
    required this.user,
    required this.fullName,
    required this.bio,
    this.location,
    required this.birthDate,
    required this.verified,
    required this.isPrivate,
    required this.totalLikes,
    required this.followers,
    required this.following,
    required this.totalPosts,
    required this.createdAt,
    required this.updatedAt,
    required this.isBlocked,
    required this.isFollowed,
    required this.isFollowing,
    required this.avatar,
  });

  /// Creates a new `ProfileModel` instance from a JSON object.
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      user: json['user'] ?? 'Unknown User',
      fullName: json['full_name'] ?? 'No Name Provided',
      bio: json['bio'] ?? 'No bio available',
      location: json['location'], // Optional, already nullable
      birthDate: json['birth_date'] ?? '1970-01-01',
      verified: json['verified'] ?? false,
      isPrivate: json['is_private'] ?? false,
      totalLikes: json['total_likes'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      totalPosts: json['total_posts'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isBlocked: json['is_blocked'] ?? false,
      isFollowed: json['is_followed'] ?? false,
      isFollowing: json['is_following'] ?? false,
      avatar: json['avatar'] ?? 'https://example.com/default-avatar.png',
    );
  }

  /// Converts the `ProfileModel` instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'full_name': fullName,
      'bio': bio,
      'location': location,
      'birth_date': birthDate,
      'verified': verified,
      'is_private': isPrivate,
      'total_likes': totalLikes,
      'followers': followers,
      'following': following,
      'total_posts': totalPosts,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_blocked': isBlocked,
      'is_followed': isFollowed,
      'is_following': isFollowing,
      'avatar': avatar,
    };
  }

  /// Creates a copy of the `ProfileModel` instance with updated fields.
  ProfileModel copyWith({
    int? id,
    String? user,
    String? fullName,
    String? bio,
    String? location,
    String? birthDate,
    bool? verified,
    bool? isPrivate,
    int? totalLikes,
    int? followers,
    int? following,
    int? totalPosts,
    String? createdAt,
    String? updatedAt,
    bool? isBlocked,
    bool? isFollowed,
    bool? isFollowing,
    String? avatar,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      user: user ?? this.user,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      birthDate: birthDate ?? this.birthDate,
      verified: verified ?? this.verified,
      isPrivate: isPrivate ?? this.isPrivate,
      totalLikes: totalLikes ?? this.totalLikes,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      totalPosts: totalPosts ?? this.totalPosts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isBlocked: isBlocked ?? this.isBlocked,
      isFollowed: isFollowed ?? this.isFollowed,
      isFollowing: isFollowing ?? this.isFollowing,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  String toString() {
    return 'ProfileModel(id: $id, user: $user, fullName: $fullName, bio: $bio, '
        'location: $location, birthDate: $birthDate, verified: $verified, '
        'isPrivate: $isPrivate, totalLikes: $totalLikes, followers: $followers, '
        'following: $following, totalPosts: $totalPosts, createdAt: $createdAt, '
        'updatedAt: $updatedAt, isBlocked: $isBlocked, isFollowed: $isFollowed, '
        'isFollowing: $isFollowing, avatar: $avatar)';
  }
}
