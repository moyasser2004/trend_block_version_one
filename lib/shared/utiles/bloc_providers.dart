import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/add_post/bloc/Add_Post_cubit.dart';
import 'package:trend/features/add_post/domain/repositories/AddNewPost_Function.dart';
import 'package:trend/features/authentication/bloc/authentication_bloc.dart';
import 'package:trend/features/authentication/bloc/authentication_event.dart';
import 'package:trend/features/authentication/domain/repositories/auth_repository.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_Bloc.dart';
import 'package:trend/features/notifications/data/repositories/notification_repository.dart';
import 'package:trend/features/notifications/domain/usecases/fetch_notifications.dart';
import 'package:trend/features/notifications/presentation/Manager/NotificationBloc/notification_bloc.dart';
import 'package:trend/features/posts/data/data_sources/data_remote_source.dart';
import 'package:trend/features/posts/domain/repositories/post_repository_impl.dart';
import 'package:trend/features/posts/domain/use_cases/get_posts.dart';
import 'package:trend/features/profile/presentation/Manager/PostForSpecificUser/PostsForspecificUserBloc.dart';
import 'package:trend/shared/utiles/dependancy_injection.dart';

import '../../features/explore/presentation/manager/tap_bar/explore_search_tap_bar_bloc.dart';
import '../../features/notifications/presentation/Manager/FollowBack/FollowBackBloc.dart';
import '../../features/posts/presentation/Manager/Bloc_Current_user/Current _user_Bloc.dart';
import '../../features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import '../../features/posts/presentation/Manager/Bloc_post/post_event.dart';
import '../../features/profile/data/data_sources/profile_remote_datasource.dart';
import '../../features/profile/data/models/currentUser.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/Manager/Bloc_BlockAndunBlock/blockandunblock.dart';
import '../../features/profile/presentation/Manager/Bloc_Following/bloc_folllowing.dart';
import '../../features/profile/presentation/Manager/Bloc_get_User/bloc_get.dart';
import '../../features/profile/presentation/Manager/Display_Following_bloc/followers_bloc.dart';
import '../../features/profile/presentation/Manager/Display_followerBloc/followers_bloc.dart';
import '../../features/profile/presentation/Manager/bloc/profile_bloc.dart';

class AppBlocProviders {
  late currentUser user;

  static MultiBlocProvider getBlocProviders({required Widget child}) {
    final dio = Dio();

    // Repositories
    final postRepository = PostRepositoryImpl(DataRemoteSource(getIt.get()));
    final profileDataSource = ProfileRemoteDatasource(dio);
    final profileRepository = ProfileRepository(profileDataSource);
    final notificationRepository = NotificationRepository(dio: dio);
    final fetchNotificationsUseCase =
        FetchNotificationsUseCase(repository: notificationRepository);

    // Use Cases

    final getPosts = GetPosts(postRepository);
    final Addnewpostrepo addnewpostrepo = Addnewpostrepo();

    return MultiBlocProvider(
      providers: [
        // Authentication Bloc: Handles user authentication, login, logout, and session status.
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            final bloc = AuthenticationBloc(authApi: AuthenticationApi());
            bloc.add(AuthenticationCheckStatusEvent());
            return bloc;
          },
        ),

        // Post Bloc: Manages posts, including fetching posts and interacting with them.
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(postRepository)
            ..add(FetchPosts()), // Automatically fetch posts
        ),

        BlocProvider<AddPostBloc>(
          create: (context) => AddPostBloc(addnewpostrepo),
        ),
        //BottomNav Bloc
        BlocProvider<BottomNavBloc>(
          create: (context) => BottomNavBloc(),
        ),

        // BlocProvider<ExploreBloc>(
        //   create: (context) =>
        //       ExploreBloc(exploreApi: ExploreApi(dio: dio), getPostsUseCase: null),
        // ),

        BlocProvider<AddPostBloc>(
          create: (context) => AddPostBloc(addnewpostrepo),
        ),
        //BottomNav Bloc
        BlocProvider<BottomNavBloc>(
          create: (context) => BottomNavBloc(),
        ),
        // Profile Bloc: Handles fetching and managing user profile data.
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(profileRepository),
        ),
        //User
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(dio, profileRepository),
        ),
        //Following Bloc
        BlocProvider<FollowingBloc>(
          create: (context) => FollowingBloc(profileRepository),
        ),
        BlocProvider<Blockbloc>(
          create: (context) => Blockbloc(profileDataSource),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(
              fetchNotificationsUseCase: fetchNotificationsUseCase),
        ),
        BlocProvider<CurrentUserBloc>(
          create: (context) => CurrentUserBloc(postRepository),
        ),
        BlocProvider<FollowersBloc>(
          create: (context) => FollowersBloc(profileRepository),
        ),
        BlocProvider<DisplayFollowingBloc>(
          create: (context) => DisplayFollowingBloc(profileRepository),
        ),
        BlocProvider<FollowingbackBloc>(
          create: (context) => FollowingbackBloc(dio, profileRepository),
        ),

        BlocProvider<TabBloc>(
          create: (context) => TabBloc(),
        ),

        BlocProvider<PostsForuserBloc>(
          create: (context) => PostsForuserBloc(dio: dio),
        ),
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(postRepository)..add(FetchPosts()),
        ),
      ],
      child: child,
    );
  }
}
