import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_Current_user/Current%20_user_event.dart';
import 'package:trend/features/posts/bloc/Bloc_Current_user/Current%20_user_state.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/domain/repositories/post_repository.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentuserState> {
  final PostRepository repository;
  CurrentUserBloc(this.repository) : super(GetPostForCurrentUserInit()) {
    on<GetPostForCurrentUserEvent>(_GetPostForCurrentUser);
  }

  Future<void> _GetPostForCurrentUser(
      GetPostForCurrentUserEvent event, Emitter<CurrentuserState> state) async {
    try {
      emit(GetPostForCurrentUserLoading());
      List<PostModel> posts = await repository.getPostForspecificUser(event.id);
      emit(GetPostForCurrentUserSuccess(posts: posts));
    } catch (e) {
      emit(GetPostForCurrentUserFailuer());
    }
  }
}
