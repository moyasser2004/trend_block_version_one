import 'package:dartz/dartz.dart';
import 'package:trend/features/explore/domain/repositories/get_post_base_repository.dart';

import '../../../../shared/core/failure.dart';
import '../entities/all_post.dart';

class GetPostWithPageNumberUseCase {
  final BaseExploreRepository baseGetPostRepository;

  GetPostWithPageNumberUseCase({required this.baseGetPostRepository});

  Future<Either<Failure, AllPost>> execute(String url) async {
    return await baseGetPostRepository.getAllPostsWithPageNumberExplore(url);
  }
}
