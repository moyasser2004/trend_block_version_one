import 'package:bloc/bloc.dart';
import '../../../../../shared/core/enum.dart';
import '../../../domain/use_cases/hashtags_use_case.dart';
import 'hashtags_event.dart';
import 'hashtags_state.dart';



class HashtagsBloc extends Bloc<HashtagsSearchEvent, HashtagsSearchState> {
  final HashtagsUseCase hashtagsUseCase;
  HashtagsBloc({required this.hashtagsUseCase}) : super(HashtagsSearchState()) {
    on<HashtagsEvent>((event, emit) async {
      // Emit a loading state before making the request
      emit(state.copyWith(status: RequestStates.loading));
      final result = await hashtagsUseCase.execute(event.query);
      result.fold((l) {
        emit(state.copyWith(
          searchMessage: l.message,
          status: RequestStates.error,
        ));
      }, (r) {
        emit(state.copyWith(
            searchResult: r, status
            : RequestStates.loaded));
      });
    });
  }
}
