import 'package:dartz/dartz.dart';
import 'package:trend/features/explore/domain/repositories/get_post_base_repository.dart';

import '../../../../shared/core/failure.dart';
import '../entities/all_post.dart';

class GetPostsUseCase {
  final BaseExploreRepository baseGetPostRepository;

  GetPostsUseCase({required this.baseGetPostRepository});

  Future<Either<Failure, AllPost>> execute() async {
    return await baseGetPostRepository.getAllPostsExplore();
  }
}
