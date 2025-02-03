import 'package:dartz/dartz.dart';

import '../../../../shared/core/failure.dart';
import '../entities/user_search.dart';
import '../repositories/get_post_base_repository.dart';

class UserSearchUseCase {
  final BaseExploreRepository baseGetPostRepository;

  UserSearchUseCase({required this.baseGetPostRepository});

  Future<Either<Failure, UserSearch>> execute(String query) async {
    return await baseGetPostRepository.userSearch(query);
  }
}
