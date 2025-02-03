class User {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? avatar;
  final String? bio;
  final String? mobile; // يمكن أن يكون null
  final int followers;
  final int following;
  final int totalPosts; // عدد المنشورات
  final int totalLikes;
  final bool is_private; // عدد الإعجابات

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.is_private,
    this.fullName,
    this.avatar,
    this.bio,
    this.mobile,
    required this.followers,
    required this.following,
    required this.totalPosts,
    required this.totalLikes,
  });

  // Factory لتحويل JSON إلى كائن User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      mobile: json['mobile'] as String?, // إذا لم يكن موجودًا سيكون null
      followers: json['followers'] as int,
      following: json['following'] as int,
      totalPosts: json['total_posts'] as int,
      totalLikes: json['total_likes'] as int,
      is_private: json["is_private"] as bool,
    );
  }

  // تحويل كائن User إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'full_name': fullName,
      'avatar': avatar,
      'bio': bio,
      'mobile': mobile,
      'followers': followers,
      'following': following,
      'total_posts': totalPosts,
      'total_likes': totalLikes,
    };
  }
}
