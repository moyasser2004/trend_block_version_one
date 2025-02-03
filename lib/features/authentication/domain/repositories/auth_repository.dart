import 'package:dio/dio.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/authentication/domain/entities/user.dart';

import '../../../../shared/const/app_links.dart';

class AuthenticationApi {
  final dio = Dio(BaseOptions(
    followRedirects: true, // Automatically follow redirects
    validateStatus: (status) {
      return status! < 500; // Allow all status codes below 500
    },
  ));

  AuthenticationApi();

  Future<User> login(String username, String password) async {
    try {
      print("object");
      final response = await dio.post(
        ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );
      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");
      await token.setToken(response.data["access"]);
      final data = response.data['user_info'];

      return User(
          id: response.data["data"]['id']?.toString() ??
              "", // إذا كان id null، يتم تعيين قيمة فارغة
          username: response.data["data"]['username'] ??
              "", // إذا كان username null، يتم تعيين قيمة فارغة
          email: response.data["data"]['email'] ??
              "", // إذا كان email null، يتم تعيين قيمة فارغة
          fullName: response.data["data"]['full_name'], // يمكن أن يكون null
          avatar: response.data["data"]['avatar'], // يمكن أن يكون null
          bio: response.data["data"]['bio'], // يمكن أن يكون null
          mobile: response.data["data"]['mobile'], // يمكن أن يكون null
          followers: response.data["data"]['followers'] ??
              0, // إذا كان null، يتم تعيين 0
          following: response.data["data"]['following'] ??
              0, // إذا كان null، يتم تعيين 0
          totalPosts: response.data["data"]['total_posts'] ??
              0, // إذا كان null، يتم تعيين 0
          totalLikes: response.data["data"]['total_likes'] ??
              0, // إذا كان null، يتم تعيين 0
          is_private: response.data["is_private"]);
    } catch (e) {
      print('API Error: $e'); // Debugging the exception.
      throw Exception('Failed to login: $e'); // Pass it along for handling.
    }
  }

  Future<User> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.register,
        data: {
          'username': username,
          'email': email,
          'password': password,
          'password_confirm': passwordConfirm,
        },
      );

      await token.setToken(response.data["data"]["tokens"]["access"]);
      // Check for a success message in the response
      return User(
          id: response.data["data"]['id']?.toString() ??
              "", // إذا كان id null، يتم تعيين قيمة فارغة
          username: response.data["data"]['username'] ??
              "", // إذا كان username null، يتم تعيين قيمة فارغة
          email: response.data["data"]['email'] ??
              "", // إذا كان email null، يتم تعيين قيمة فارغة
          fullName: "", // يمكن أن يكون null
          avatar: response.data["data"]['avatar'], // يمكن أن يكون null
          bio: "", // يمكن أن يكون null
          mobile: "", // يمكن أن يكون null
          followers: 0, // إذا كان null، يتم تعيين 0
          following: 0, // إذا كان null، يتم تعيين 0
          totalPosts: 0, // إذا كان null، يتم تعيين 0
          totalLikes: 0, // إذا كان null، يتم تعيين 0
          is_private: false);

      // Example: "User registered successfully."
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      final response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {'email': email},
      );
      return response.data['message'];
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }
}
