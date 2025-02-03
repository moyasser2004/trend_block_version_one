import 'package:bloc/bloc.dart';
import 'package:trend/features/explore/domain/use_cases/get_post_with_page_number_use_case.dart';
import 'package:trend/features/explore/domain/use_cases/get_posts_use_case.dart';
import '../../../../../shared/core/enum.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetPostsUseCase getPostsUseCase;
  final GetPostWithPageNumberUseCase getPostWithPageNumberUseCase;

  ExploreBloc({
    required this.getPostsUseCase,
    required this.getPostWithPageNumberUseCase,
  }) : super(ExploreState()) {
    on<GetAllPostsEvent>(_onGetAllPosts);
    on<GetPostWithPageNumberEvent>(_onGetPostWithPageNumber);
  }

  Future<void> _onGetAllPosts(
      GetAllPostsEvent event,
      Emitter<ExploreState> emit,
      ) async {
    emit(state.copyWith(requestStatus: RequestStates.loading));

    final result = await getPostsUseCase.execute();

    result.fold(
          (failure) {
        emit(state.copyWith(
          requestStatus: RequestStates.error,
          getExploreAllPostMessage: failure.message,
        ));
      },
          (posts) {
        emit(state.copyWith(
          allPost: posts,
          requestStatus: RequestStates.loaded,
        ));
      },
    );
  }

  Future<void> _onGetPostWithPageNumber(
      GetPostWithPageNumberEvent event,
      Emitter<ExploreState> emit,
      ) async {
    if (state.allPost.next == null || state.allPost.next!.isEmpty) {
      return; // No more pages to load
    }

    final result = await getPostWithPageNumberUseCase.execute(state.allPost.next!);

    result.fold(
          (failure) {
        emit(state.copyWith(
          requestStatus: RequestStates.error,
          getExploreAllPostMessage: failure.message,
        ));
      },
          (newPosts) {
        emit(state.appendPosts(newPosts));
      },
    );
  }
}