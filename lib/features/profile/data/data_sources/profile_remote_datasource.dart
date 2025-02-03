import 'package:dio/dio.dart';
import 'package:trend/features/profile/data/models/FolloersModel.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/shared/core/shared_preferences.dart';

class ProfileRemoteDatasource {
  final Dio dio;

  ProfileRemoteDatasource(this.dio);

  Future<ProfileModel?> getProfile(int id) async {
    try {
      final String? tok = await token.getToken();
      final response = await dio.get(
        '/profile/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $tok'}, // Ensure token is included
        ),
      );
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      }
      throw Exception('Failed to load profile');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> followUser(int id) async {
    try {
      final String? tok = await token.getToken();
      final response = await dio.post(
        'http://167.71.92.176/profile/follow/$id/',
        options: Options(headers: {'Authorization': 'Bearer $tok'}),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> unfollowUser(int id) async {
    try {
      String? tok = await token.getToken();
      final response =
          await dio.post('http://167.71.92.176/profile/unfollow/$id/',
              options: Options(
                headers: {'Authorization': 'Bearer $tok'},
              ));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProfileModel> fetchUserById(int id) async {
    try {
      final response = await dio.get('http://167.71.92.176/profile/$id/',
          options: Options(
            headers: {'Authorization': 'Bearer ${token.getToken()}'},
          ));
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  Future<List<FollowerModel>> fetchFollowers({required int id}) async {
    try {
      final response =
          await dio.get("http://167.71.92.176/profile/$id/followers/",
              options: Options(
                headers: {'Authorization': 'Bearer ${token.getToken()}'},
              ));
      if (response.statusCode == 200) {
        List<FollowerModel> followers = (response.data['results'] as List)
            .map((json) => FollowerModel.fromJson(json))
            .toList();
        return followers;
      } else {
        throw Exception('Failed to load followers');
      }
    } catch (e) {
      throw Exception('Error fetching followers: $e');
    }
  }

  Future<List<FollowerModel>> fetchFollowing({required int id}) async {
    try {
      final response =
          await dio.get("http://167.71.92.176/profile/$id/following/",
              options: Options(
                headers: {'Authorization': 'Bearer ${token.getToken()}'},
              ));
      if (response.statusCode == 200) {
        List<FollowerModel> followers = (response.data['results'] as List)
            .map((json) => FollowerModel.fromJson(json))
            .toList();
        return followers;
      } else {
        throw Exception('Failed to load followers');
      }
    } catch (e) {
      throw Exception('Error fetching followers: $e');
    }
  }

  Future<bool> unblockUser(String userId) async {
    try {
      String? tok = await token.getToken();
      final url = 'http://167.71.92.176/profile/$userId/unblock/';
      final response = await dio.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $tok'}),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Error unblocking user: $e");
    }
  }
}
