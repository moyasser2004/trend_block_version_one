import 'package:dartz/dartz.dart';
import 'package:trend/features/posts/data/data_sources/data_remote_source.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/domain/repositories/post_repository.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final DataRemoteSource dataRemoteSource;

  PostRepositoryImpl(this.dataRemoteSource);

  @override
  Future<Either<Failure, List<PostModel>>> fetchPosts() async {
    try {
      // Call the remote data source with the provided URL
      List<PostModel> posts = await dataRemoteSource.fetchPosts();

      // Return the posts in the `Right` part of the Either
      return Right(posts);
    } catch (e) {
      // Handle errors and return them in the `Left` part of the Either
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment?>> commentComment(
      {required int postId,
      required int commentId,
      required String comment}) async {
    try {
      Comment? newComment = await dataRemoteSource.commentComment(
          postId: postId, commentId: commentId, comment: comment);
      return Right(newComment);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment?>> commentPost(int id, String comment) async {
    try {
      Comment? newComment = await dataRemoteSource.commentPost(id, comment);

      return Right(newComment);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> deleteComment(int id, int commentId) async {
    try {
      bool? result = await dataRemoteSource.deleteComment(id, commentId);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> likeComment(int id) async {
    try {
      bool? result = await dataRemoteSource.likeComment(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> likePost(int id) async {
    try {
      bool? result = await dataRemoteSource.likePost(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> blockUser(int id) async {
    // TODO: implement blockUser
    try {
      bool? result = await dataRemoteSource.blockUser(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> deletePost(int id) async {
    // TODO: implement deletePost
    try {
      bool? result = await dataRemoteSource.deletePost(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<String> getUserAvatar(int id) async {
    try {
      String result = await dataRemoteSource.GetUserinfoAvatar(id);

      return result;
    } catch (e) {
      return "http://167.71.92.176/media/profile_images/default_image.jpg";
    }
  }

  @override
  Future<List<PostModel>> getPostForspecificUser(int id) async {
    List<PostModel> posts =
        await dataRemoteSource.getPostForspecificUserMethod(id);
    return posts;
  }
}
