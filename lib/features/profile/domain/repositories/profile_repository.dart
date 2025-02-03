import 'package:dartz/dartz.dart';
import 'package:trend/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:trend/features/profile/data/models/FolloersModel.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepository(this.remoteDatasource);

  Future<Either<Failure, ProfileModel?>> getProfile(int id) async {
    try {
      final profile = await remoteDatasource.getProfile(id);
      return Right(profile);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<void> followUser(int id) async {
    try {
      await remoteDatasource.followUser(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> unfollowUser(int id) async {
    try {
      await remoteDatasource.unfollowUser(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<FollowerModel>> fetchFollowers({required int id}) async {
    try {
      return await remoteDatasource.fetchFollowers(id: id);
    } catch (e) {
      throw Exception('Error fetching followers: $e');
    }
  }

  Future<List<FollowerModel>> fetchFollowing({required int id}) async {
    try {
      return await remoteDatasource.fetchFollowing(id: id);
    } catch (e) {
      throw Exception('Error fetching followers: $e');
    }
  }
}

class Failure {
  final String message;

  Failure({required this.message});
}
