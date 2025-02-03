import 'package:dartz/dartz.dart';

import '../../../../shared/core/failure.dart';
import '../entities/for_you_search.dart';
import '../repositories/get_post_base_repository.dart';

class ForYouSearchUseCase {
  final BaseExploreRepository baseGetPostRepository;

  ForYouSearchUseCase({required this.baseGetPostRepository});

  Future<Either<Failure, PostSearch>> execute(String query) async {
    return await baseGetPostRepository.forYouSearch(query);
  }
}
