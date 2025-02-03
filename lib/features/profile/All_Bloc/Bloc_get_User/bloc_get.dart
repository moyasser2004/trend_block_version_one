import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/event_getU.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/states.getU.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Dio dio;
  final ProfileRepository repository;
  UserBloc(this.dio, this.repository) : super(UserInitialState()) {
    on<FetchUserEvent2>(_onFetchProfile);
    on<FetchUserEventForUpdate>(_FetchUserEventForUpdate);
  }
  Future<void> _FetchUserEventForUpdate(
    FetchUserEventForUpdate event,
    Emitter<UserState> emit,
  ) async {
    try {
      String? tok = await token.getToken();
      final response = await dio.get(
          'http://167.71.92.176/profile/${event.userId}/',
          options: Options(headers: {'Authorization': 'Bearer $tok'}));

      if (response.statusCode == 200) {
        final user = ProfileModel.fromJson(response.data);
        emit(UserLoadedState(user));
      } else {
        emit(UserErrorState('Failed to load user'));
      }
    } catch (e) {
      emit(UserErrorState('Error: $e'));
    }
  }

  /// Fetch user profile
  Future<void> _onFetchProfile(
    FetchUserEvent2 event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      String? tok = await token.getToken();
      final response = await dio.get(
          'http://167.71.92.176/profile/${event.userId}/',
          options: Options(headers: {'Authorization': 'Bearer $tok'}));

      if (response.statusCode == 200) {
        print("object1");
        final user = ProfileModel.fromJson(response.data);
        emit(UserLoadedState(user));
      } else {
        emit(UserErrorState('Failed to load user'));
      }
    } catch (e) {
      emit(UserErrorState('Error: $e'));
    }
  }

  Future<void> _getpostForUser(
    getpostForUser event,
    Emitter<UserpostsState> emit,
  ) async {
    try {
      emit(getPostLOading());
      String tok = await token.getToken() ?? "";
      final response = await dio.get(
        "http://167.71.92.176/posts/${event.userId}/posts/",
        options: Options(
          headers: {'Authorization': 'Bearer $tok'},
        ),
      );

      var data = response.data["results"];
      List<PostModel> posts = [];
      for (var element in data) {
        posts.add(PostModel.fromJson(element));
      }

      emit(getPostSuccess(posts: posts));
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}'); // Server response details
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Error: $e');
      }
    }
  }
}
