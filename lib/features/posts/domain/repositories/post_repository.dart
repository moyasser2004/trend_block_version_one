// domain/repositories/post_repository.dart
import 'package:dartz/dartz.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> fetchPosts();

  Future<Either<Failure, bool?>> likePost(int id);

  Future<Either<Failure, Comment?>> commentPost(int id, String comment);

  Future<Either<Failure, bool?>> deleteComment(int id, int commentId);

  Future<Either<Failure, Comment?>> commentComment(
      {required int postId, required int commentId, required String comment});
  Future<Either<Failure, bool?>> likeComment(int id);
  Future<Either<Failure, bool?>> blockUser(int id);
  Future<Either<Failure, bool?>> deletePost(int id);

  Future<String> getUserAvatar(int id);

  Future<List<PostModel>> getPostForspecificUser(int id);
}
