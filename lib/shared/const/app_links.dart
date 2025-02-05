class ApiEndpoints {
  static const String baseUrl = 'http://167.71.92.176:8000';

  // Authentication Endpoints URL
  static const String login = '$baseUrl/auth/login/';
  static const String register = '$baseUrl/auth/register/';
  static const String changePassword = '$baseUrl/auth/change-password/';
  static const String resetPassword = '$baseUrl/auth/reset-password/';

// // Explore Endpoints URL
  static const String getAllPosts = '$baseUrl/explore/posts/?page_size=28';

  static String getSearchPostsByUserName(String query) =>
      '$baseUrl/explore/search/user-posts/?page_size=40&q=$query';

  //static String forYouPostSearch(String query) => '$baseUrl/explore/search/user-posts/?q=$query';

  static String getTrendingHashtags(String query) =>
      '$baseUrl/explore/search/hashtag/?q=$query';
  static String getLocationSearch(String query) =>
      '$baseUrl/explore/search/location/?q=$query';
  static String getUserSearch(String query) =>
      '$baseUrl/explore/search/user/?q=$query';

  // Profile Endpoints URL
  static const String allProfiles = '$baseUrl/profile/';
  static String profileId(int id) => '$baseUrl/profile/$id/';

  // Posts Endpoints URL
  static const String allPosts = '$baseUrl/posts/all-posts/';
  static const String addPost = '$baseUrl/posts/create/';
  static String addComment(int id) => '$baseUrl/posts/$id/comments/';
  static String toggleLikePost(int id) => '$baseUrl/posts/$id/like/';
  static String getPost(int id) => '$baseUrl/posts/$id/';
  static String deletePost(int id) => '$baseUrl/posts/$id/';
  static String updatePost(int id) => '$baseUrl/posts/$id/';
  static String likeComments(int id) => '$baseUrl/posts/comments/$id/like';
  static String allPostsUser(int id) => '$baseUrl/posts/$id/posts/';

  // Notifications Endoipoints URL
  static String allNotifications(int id) => '$baseUrl/notifications/all/';

  // static const String allPosts = '$baseUrl/posts/all-posts/';
  static String? Nextpage = allPosts;

  static String getnext(int id) => '$baseUrl//posts/all-posts/?page=$id';
  static void setnext(String id) {
    Nextpage = id;
  }
}
