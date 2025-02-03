import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';

import '../../utiles/dependancy_injection.dart';


class SharedPreferencesDemo {
  Future<void> saveUserData(
      {required String id,
      required String username,
      required String email,
      required String fullName,
      required String avatar,
      required String bio,
      required String mobile,
      required String followers,
      required String following,
      required String totalPosts, // Add totalPosts
      required String totalLikes,
      required bool is_private // Add totalLikes
      }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('fullName', fullName);
    await prefs.setString('avatar', avatar);
    await prefs.setString('bio', bio);
    await prefs.setString('mobile', mobile); // Store mobile
    await prefs.setString('followers', followers); // Store followers
    await prefs.setString('following', following); // Store following
    await prefs.setString('totalPosts', totalPosts); // Store totalPosts
    await prefs.setString('totalLikes', totalLikes);
    await prefs.setBool("is_private", is_private); // Store totalLikes
  }

  static currentUser loadUserData() {
    SharedPreferences prefs = getIt.get<SharedPreferences>();
    return currentUser.fromMap({
      'id': prefs.getString('id') ?? '0', // Ensure `id` is always a String
      'username': prefs.getString('username') ?? 'username',
      'email': prefs.getString('email') ?? 'email',
      'fullName': prefs.getString('fullName') ?? '',
      'avatar': prefs.getString('avatar') ??
          "https://example.com/default_avatar.jpg", // Use a full URL
      'bio': prefs.getString('bio') ?? '',
      'mobile': prefs.getString('mobile') ?? 'null', // Load mobile
      'followers': prefs.getString('followers') ?? '0', // Load followers
      'following': prefs.getString('following') ?? '0', // Load following
      'totalPosts': prefs.getString('totalPosts') ?? '0', // Load totalPosts
      'totalLikes': prefs.getString('totalLikes') ?? '0', // Load totalLikes
      'is_private': prefs.getBool('is_private')
    });
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all data
  }

  static Future<String> getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('avatar') ??
        "https://example.com/default_avatar.jpg"; // Parse ID
  }

  static Future<int> getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return int.parse(await prefs.getString('id') ?? "0"); // Parse ID
  }
}
