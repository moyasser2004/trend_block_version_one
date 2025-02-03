import 'package:dartz/dartz.dart';

import '../../../../shared/core/failure.dart';
import '../entities/hashtags_search.dart';
import '../repositories/get_post_base_repository.dart';


class HashtagsUseCase {
  final BaseExploreRepository baseGetPostRepository;

  HashtagsUseCase({required this.baseGetPostRepository});

  Future<Either<Failure, SearchHashtags>> execute(String query) async {
    return await baseGetPostRepository.HashtagsSearch(query);
  }
}
