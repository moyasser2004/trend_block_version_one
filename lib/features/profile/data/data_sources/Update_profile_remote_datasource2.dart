import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:trend/features/explore/data/models/remote/get_all_post_model.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/shared/core/shared_preferences.dart';

class updateProfileRemoteDataSource {
  final Dio dio;

  updateProfileRemoteDataSource({required this.dio});

  Future<Response<dynamic>> updateBio(String userId, String bio) async {
    String? tok = await token.getToken();
    ;

    final data = {
      "bio": bio,
    };
    final response = await dio.put(
      "http://167.71.92.176/profile/${userId}/",
      data: FormData.fromMap(data),
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );

    return response;
  }

  Future<Response<dynamic>> updatefullname(
      String userId, String fullname) async {
    String? tok = await token.getToken();

    final data = {
      "full_name": fullname,
    };
    final response = await dio.put(
      "http://167.71.92.176/profile/${userId}/",
      data: FormData.fromMap(data),
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );

    return response;
  }

  Future<Response<dynamic>> updateAvatar(String userId, File image) async {
    String? tok = await token.getToken();

    String fileName;
    fileName = path.basename(image.path);

    final data = {
      "avatar": await MultipartFile.fromFile(image.path, filename: fileName)
    };
    final response = await dio.put(
      "http://167.71.92.176/profile/${userId}/",
      data: FormData.fromMap(data),
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );
    return response;
  }

  Future<Response<dynamic>> delete() async {
    String? tok = await token.getToken();
    final response = await dio.delete(
      "http://167.71.92.176/auth/account/delete/",
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );

    return response;
  }

  Future<List<ProfileModel>> getBlockedUser() async {
    String? tok = await token.getToken();
    final response = await dio.get(
      "http://167.71.92.176/profile/blocked/",
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );

    List<ProfileModel> users = [];
    for (var element in response.data["results"]) {
      users.add(ProfileModel.fromJson(element));
    }

    return users;
  }

  Future<List<PostModel>> getPostForUserMethod(int id) async {
    String? tok = await token.getToken();
    final response = await dio.get(
      "http://167.71.92.176/posts/${id}/posts/",
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );

    var data = response.data["results"];
    List<PostModel> posts = [];
    for (var element in data) {
      posts.add(PostModel.fromJson(element));
    }

    return posts;
  }
}
/**
 * 
 *  Future<void> _getPostForUserMethod(
    getPostForUserevent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(getPostForspecificUserLoading());
      String? tok = await token.getToken();
      final response = await dio.get(
        "http://167.71.92.176/posts/${event.id}/posts/",
        options: Options(
          headers: {'Authorization': 'Bearer $tok'},
        ),
      );

      var data = response.data["results"];
      List<PostModel> posts = [];
      for (var element in data) {
        posts.add(PostModel.fromJson(element));
      }

      emit(getPostForspecificUser(posts: posts));
    } catch (e) {
      // if (e is DioException) {
      //   print('DioError: ${e.response?.data}'); // Server response details
      //   print('Status code: ${e.response?.statusCode}');
      // } else {
      //   print('Error: $e');
      // }
    }
  }
 */
/**
 * 
 * Future<void> _Updatefullname(
    Updatefullname event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(UpdateLoading());
      String? tok = await token.getToken();
      final data = {
        "full_name": event.full_name.isEmpty ?? true ? null : event.full_name,
      };
      final response = await dio.put(
        "http://167.71.92.176/profile/${event.id}/",
        data: FormData.fromMap(data),
        options: Options(
          headers: {'Authorization': 'Bearer $tok'},
        ),
      );

      if (response.statusCode == 200) {
        emit(Updatesuccess(
          response.data["avatar"],
          response.data["bio"] ?? "",
          response.data["full_name"] ?? "",
        ));
      } else {
        emit(UpdateFailuer());
      }
    } catch (e) {
      print("Error: $e");
      emit(UpdateFailuer());
    }
  }
 */

//   Future<Map<String, dynamic>> updateFullName(String userId, String fullName, String token) async {
//     final data = {"full_name": fullName.isEmpty ? null : fullName};
//     return _sendUpdateRequest(userId, data, token);
//   }
