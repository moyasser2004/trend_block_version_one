import 'package:dartz/dartz.dart';

import '../../../../shared/core/failure.dart';
import '../entities/location_search.dart';
import '../repositories/get_post_base_repository.dart';



class LocationSearchUseCase {
  final BaseExploreRepository baseGetPostRepository;

  LocationSearchUseCase({required this.baseGetPostRepository});

  Future<Either<Failure,LocationsSearch >> execute(String query)async {
    return await baseGetPostRepository.locationSearch(query);
  }
}