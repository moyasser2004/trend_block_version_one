class currentUser {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String avatar;
  final String bio;
  final String mobile;
  final String followers;
  final String following;
  final String totalPosts; // New field
  final String totalLikes; // New field
  final bool is_private; // New field

  currentUser({
    required this.id,
    required this.username,
    required this.is_private,
    required this.email,
    required this.fullName,
    required this.avatar,
    required this.bio,
    required this.mobile,
    required this.followers,
    required this.following,
    required this.totalPosts, // New parameter
    required this.totalLikes, // New parameter
  });

  factory currentUser.fromMap(Map<String, dynamic> map) {
    return currentUser(
      id: int.tryParse(map['id'] ?? '0') ?? 0, // Safely parse ID
      username: map['username'] ?? 'Guest', // Fallback username
      email: map['email'] ?? 'unknown@example.com', // Fallback email
      fullName: map['fullName'] ?? '', // Default empty string
      avatar: map['avatar'] ??
          "/media/profile_images/default_image.jpg", // Default avatar
      bio: map['bio'] ?? '', // Default empty bio
      is_private: map['is_private'] ?? false,
      mobile: map['mobile'] ?? 'null', // Default value if mobile is missing
      followers:
          map['followers']?.toString() ?? '0', // Ensure followers is a string
      following:
          map['following']?.toString() ?? '0', // Ensure following is a string
      totalPosts:
          map['totalPosts']?.toString() ?? '0', // Ensure totalPosts is a string
      totalLikes:
          map['totalLikes']?.toString() ?? '0', // Ensure totalLikes is a string
    );
  }
}
