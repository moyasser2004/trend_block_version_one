
// import 'package:dio/dio.dart';
// import 'package:trend/features/posts/data/models/post_model.dart';
// import 'package:trend/features/profile/data/models/profile_model.dart';
// import 'package:trend/features/profile/domain/repositories/Repo_profile.dart';
// import 'package:trend/shared/core/local/SharedPreferencesDemo.dart';
// import 'package:trend/shared/core/shared_preferences.dart';

// class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
//   final Dio dio;

//   ProfileRemoteDataSourceImpl(this.dio);
  
//   get path => null;

//   Future<String?> _getToken() async {
//     return await token.getToken();
//   }

//   @override
//   Future<ProfileModel?> getProfile(String id) async {
//     String? tok = await _getToken();
//     final response = await dio.get(
//       "http://167.71.92.176/profile/$id/",
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );
//     return response.statusCode == 200 ? ProfileModel.fromJson(response.data) : null;
//   }

//   @override
//   Future<List<PostModel>> getPostsForUser(String id) async {
//     String? tok = await _getToken();
//     final response = await dio.get(
//       "http://167.71.92.176/posts/$id/posts/",
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );

//     return (response.data["results"] as List)
//         .map((post) => PostModel.fromJson(post))
//         .toList();
//   }

//   @override
//   Future<List<ProfileModel>> getBlockedUsers() async {
//     String? tok = await _getToken();
//     final response = await dio.get(
//       "http://167.71.92.176/profile/blocked/",
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );

//     return (response.data["results"] as List)
//         .map((user) => ProfileModel.fromJson(user))
//         .toList();
//   }

//   @override
//   Future<void> logout() async {
//     SharedPreferencesDemo sh = SharedPreferencesDemo();
//     await sh.clearUserData();
//   }

//   @override
//   Future<void> deleteAccount() async {
//     String? tok = await _getToken();
//     await dio.delete(
//       "http://167.71.92.176/auth/account/delete/",
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );
//   }

//   @override
//   Future<void> updateBio(String id, String bio) async {
//     String? tok = await _getToken();
//     final data = {"bio": bio};
//     await dio.put(
//       "http://167.71.92.176/profile/$id/",
//       data: FormData.fromMap(data),
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );
//   }

//   @override
//   Future<void> updateFullName(String id, String fullName) async {
//     String? tok = await _getToken();
//     final data = {"full_name": fullName};
//     await dio.put(
//       "http://167.71.92.176/profile/$id/",
//       data: FormData.fromMap(data),
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );
//   }

//   @override
//   Future<void> updateAvatar(String id, String imagePath) async {
//     String? tok = await _getToken();
//     String fileName = path.basename(imagePath);

//     final data = {
//       "avatar": await MultipartFile.fromFile(imagePath, filename: fileName),
//     };

//     await dio.put(
//       "http://167.71.92.176/profile/$id/",
//       data: FormData.fromMap(data),
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );
//   }

//   @override
//   Future<void> updatePrivacy(String id, bool isPrivate) async {
//     String? tok = await _getToken();
//     final data = {"is_private": isPrivate};

//     await dio.put(
//       "http://167.71.92.176/profile/$id/",
//       data: FormData.fromMap(data),
//       options: Options(headers: {'Authorization': 'Bearer $tok'}),
//     );
//   }
// }
