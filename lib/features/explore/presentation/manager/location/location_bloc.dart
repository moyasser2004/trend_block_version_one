import 'package:bloc/bloc.dart';
import 'package:trend/features/explore/domain/use_cases/location_search.dart';
import 'package:trend/features/explore/presentation/manager/location/location_state.dart';
import '../../../../../shared/core/enum.dart';
import 'location_event.dart';




class LocationSearchesBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  final LocationSearchUseCase locationSearchUseCase;
  LocationSearchesBloc({required this.locationSearchUseCase}) : super(LocationSearchState()) {
    on<LocationEvent>((event, emit) async {
      // Emit a loading state before making the request
      emit(state.copyWith(status: RequestStates.loading));
      final result = await locationSearchUseCase.execute(event.query);
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
