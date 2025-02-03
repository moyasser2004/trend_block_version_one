import 'package:dartz/dartz.dart';
import 'package:trend/features/explore/data/models/remote/get_all_post_model.dart';
import 'package:trend/features/explore/domain/entities/location_search.dart';
import 'package:trend/features/explore/domain/repositories/get_post_base_repository.dart';
import 'package:trend/shared/core/failure.dart';

import '../../../../shared/core/network/server_exception.dart';
import '../data_sources/get_post_data_source.dart';
import '../models/remote/hashtags_model.dart';
import '../models/remote/location_search_model.dart';
import '../models/remote/search_model.dart';
import '../models/remote/user_search_model.dart';

class ExploreRepository extends BaseExploreRepository {
  final BasePostDataSource basePostDataSource;

  ExploreRepository({required this.basePostDataSource});

  @override
  Future<Either<Failure, AllPostModel>> getAllPostsExplore() async {
    try {
      final result = await basePostDataSource.getAllPosts();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(failure.errorServerModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, AllPostModel>>
      getAllPostsWithPageNumberExplore(String url) async {
    try {
      final result =
          await basePostDataSource.getPostWithPageNumber(url);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(failure.errorServerModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, PostSearchModel>> forYouSearch(
      String query) async {
    try {
      final result = await basePostDataSource.forYouSearch(query);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(failure.errorServerModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, SearchHashtagsModel>> HashtagsSearch(
      String query) async {
    try {
      final result = await basePostDataSource.HashtagsSearch(query);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(failure.errorServerModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, UserSearchModel>> userSearch(
      String query) async {
    try {
      final result = await basePostDataSource.UserSearch(query);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(failure.errorServerModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, LocationsSearchModel>> locationSearch(
      String query) async {
    try {
      final result = await basePostDataSource.LocationSearch(query);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
          ServerFailure(failure.errorServerModel.statusMessage));
    }
  }
}
