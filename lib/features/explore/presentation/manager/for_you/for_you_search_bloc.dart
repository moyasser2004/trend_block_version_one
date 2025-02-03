import 'package:bloc/bloc.dart';
import 'package:trend/features/explore/domain/use_cases/user_search_use_case.dart';

import '../../../../../shared/core/enum.dart';
import '../../../domain/use_cases/for_you_use_case.dart';
import 'for_you_search_event.dart';
import 'for_you_search_state.dart';

class ForYouSearchBloc extends Bloc<ForYouSearchEvent, ForYouSearchState> {
  final ForYouSearchUseCase searchExploreUseCase;
  final UserSearchUseCase userSearchUseCase;

  ForYouSearchBloc(
      {required this.searchExploreUseCase, required this.userSearchUseCase})
      : super(ForYouSearchState()) {
    
    
    on<PostSearchEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStates.loading));
      final result = await searchExploreUseCase.execute(event.query);
      result.fold(
        (l) {
          emit(state.copyWith(
            searchMessage: l.message,
            status: RequestStates.error,
          ));
        },
        (r) {
          emit(state.copyWith(
            searchResult: r,
            status: RequestStates.loaded,
          ));
        },
      );
    });

    on<UserSearchEvent>((event, emit) async {
      emit(state.copyWith(userStatus: RequestStates.loading));
      final result = await userSearchUseCase.execute(event.query);
      result.fold(
        (l) {
          emit(state.copyWith(
            userSearchMessage: l.message,
            userStatus: RequestStates.error,
          ));
        },
        (r) {
          emit(state.copyWith(
            userSearch: r,
            userStatus: RequestStates.loaded,
          ));
        },
      );
    });
  }
}
