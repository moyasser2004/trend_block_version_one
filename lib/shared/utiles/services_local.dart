import 'package:get_it/get_it.dart';

import '../../features/explore/data/data_sources/get_post_data_source.dart';
import '../../features/explore/data/repositories/explore_repository.dart';
import '../../features/explore/domain/repositories/get_post_base_repository.dart';
import '../../features/explore/domain/use_cases/for_you_use_case.dart';
import '../../features/explore/domain/use_cases/get_post_with_page_number_use_case.dart';
import '../../features/explore/domain/use_cases/get_posts_use_case.dart';
import '../../features/explore/domain/use_cases/hashtags_use_case.dart';
import '../../features/explore/domain/use_cases/location_search.dart';
import '../../features/explore/domain/use_cases/user_search_use_case.dart';
import '../../features/explore/presentation/manager/explore/explore_bloc.dart';
import '../../features/explore/presentation/manager/explore/explore_event.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    // this is for explore block injection
    sl.registerFactory(() => ExploreBloc(getPostsUseCase: sl(),getPostWithPageNumberUseCase:  sl())
      ..add(GetAllPostsEvent()));

    // this is for data source injection
    sl.registerLazySingleton<BasePostDataSource>(
        () => PostDataSource());

    // this is for repository injection
    sl.registerLazySingleton<BaseExploreRepository>(
        () => ExploreRepository(
              basePostDataSource: sl(),
            ));

    // this is for use case injection
    sl.registerLazySingleton(
        () => GetPostsUseCase(baseGetPostRepository: sl()));
    sl.registerLazySingleton(
        () => ForYouSearchUseCase(baseGetPostRepository: sl()));
    sl.registerLazySingleton(
        () => HashtagsUseCase(baseGetPostRepository: sl()));
    sl.registerLazySingleton(() =>
        GetPostWithPageNumberUseCase(baseGetPostRepository: sl()));
    sl.registerLazySingleton(() =>
        UserSearchUseCase(baseGetPostRepository: sl()));
    sl.registerLazySingleton(() =>
        LocationSearchUseCase(baseGetPostRepository: sl()));
  }
}
