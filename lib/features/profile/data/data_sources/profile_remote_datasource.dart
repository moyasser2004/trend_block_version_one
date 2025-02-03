// import 'package:dio/dio.dart';
// import 'package:trend/features/profile/data/models/FolloersModel.dart';
// import 'package:trend/features/profile/data/models/profile_model.dart';

// class ProfileRemoteDatasource {
//   final Dio dio;

//   ProfileRemoteDatasource(this.dio);

//   Future<ProfileModel> getProfile(int id) async {
//     final String url = 'http://167.71.92.176/profile/$id/'; // Construct the URL
//     print('Fetching profile for ID: $id'); // Log the ID being used
//     print('URL: $url'); // Log the URL being requested

//     try {
//       final response = await dio.get(
//         url,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer YOUR_ACCESS_TOKEN'
//           }, // Ensure token is included
//         ),
//       );
//       print(
//           'Response data: ${response.data}'); // Log the response data for debugging
//       return ProfileModel.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to fetch profile: $e');
//     }
//   }

//   Future<List<FollowerModel>> fetchFollowers({required int id}) async {
//     try {
//       final response =
//           await dio.get("http://167.71.92.176/profile/$id/followers/");
//       if (response.statusCode == 200) {
//         List<FollowerModel> followers = (response.data['results'] as List)
//             .map((json) => FollowerModel.fromJson(json))
//             .toList();
//         return followers;
//       } else {
//         throw Exception('Failed to load followers');
//       }
//     } catch (e) {
//       throw Exception('Error fetching followers: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/profile/data/models/FolloersModel.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';

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
}
