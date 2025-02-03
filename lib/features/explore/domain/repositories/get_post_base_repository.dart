import 'package:dartz/dartz.dart';

import '../../../../shared/core/failure.dart';
import '../../data/models/remote/get_all_post_model.dart';
import '../entities/for_you_search.dart';
import '../entities/hashtags_search.dart';
import '../entities/location_search.dart';
import '../entities/user_search.dart';



abstract class BaseExploreRepository {
  Future<Either<Failure,AllPostModel>> getAllPostsExplore();
  Future<Either<Failure,AllPostModel>> getAllPostsWithPageNumberExplore(String url);
  Future<Either<Failure,PostSearch>> forYouSearch(String query);
  Future<Either<Failure,UserSearch>> userSearch(String query);
  Future<Either<Failure,SearchHashtags>> HashtagsSearch(String query);
  Future<Either<Failure,LocationsSearch >> locationSearch(String query);
}