import 'dart:io';

import 'package:dio/dio.dart';
import 'package:trend/features/explore/data/models/remote/get_all_post_model.dart';
import 'package:trend/features/profile/data/data_sources/Update_profile_remote_datasource2.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';

class UpdateProfileRepository {
  final updateProfileRemoteDataSource remoteDataSource; // كلاس لإدارة التوكن

  UpdateProfileRepository({required this.remoteDataSource});

  Future<Response<dynamic>> updateBio(String userId, String bio) async {
    return await remoteDataSource.updateBio(userId, bio);
  }

  Future<Response<dynamic>> updatefullname(
      String userId, String fullname) async {
    return await remoteDataSource.updatefullname(userId, fullname);
  }

  Future<Response<dynamic>> updateAvatar(String userId, File image) async {
    return await remoteDataSource.updateAvatar(userId, image);
  }

  Future<Response<dynamic>> delete() async {
    return await remoteDataSource.delete();
  }

  Future<List<ProfileModel>> getBlockedUser() async {
    return await remoteDataSource.getBlockedUser();
  }

  Future<List<PostModel>> getPostForUserMethod(int id) async {
    return await remoteDataSource.getPostForUserMethod(id);
  }
//   Future<Map<String, dynamic>> updateFullName(
//       String userId, String fullName) async {
//     String? tok = await token.getToken();
//     return remoteDataSource.updateFullName(userId, fullName, tok!);
//   }

//   Future<Map<String, dynamic>> updateAvatar(
//       String userId, String imagePath) async {
//     String? tok = await token.getToken();
//     return remoteDataSource.updateAvatar(userId, imagePath, tok!);
//   }
}
