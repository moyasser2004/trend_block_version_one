import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/explore/data/models/remote/get_all_post_model.dart';
import 'package:trend/features/profile/presentation/Manager/PostForSpecificUser/PostsForspecificUserEvent.dart';
import 'package:trend/features/profile/presentation/Manager/PostForSpecificUser/PostsForspecificUserstate.dart';
import 'package:trend/shared/core/shared_preferences.dart';

class PostsForuserBloc extends Bloc<PostEvent, PostforuserState> {
  final Dio dio;

  PostsForuserBloc({required this.dio}) : super(InitialPostState()) {
    on<GetUserPostsEvent>(_getUserPosts);
  }

  Future<void> _getUserPosts(
      GetUserPostsEvent event, Emitter<PostforuserState> emit) async {
    try {
      emit(LoadingUserPostsState());

      String? tok = await token.getToken();
      final response = await dio.get(
        "http://167.71.92.176/posts/${event.userId}/posts/",
        options: Options(headers: {'Authorization': 'Bearer $tok'}),
      );

      var data = response.data["results"];
      List<PostModel> posts =
          data.map<PostModel>((json) => PostModel.fromJson(json)).toList();

      emit(LoadedUserPostsState(posts: posts));
    } catch (e) {
      if (e is DioException) {
        emit(ErrorUserPostsState(message: 'Error: ${e.response?.data}'));
      } else {
        emit(ErrorUserPostsState(message: 'Unexpected error: $e'));
      }
    }
  }
}
