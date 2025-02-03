import 'package:equatable/equatable.dart';
import 'package:trend/features/explore/domain/entities/location_search.dart';
import '../../../../../shared/core/enum.dart';


class LocationSearchState extends Equatable {
  final LocationsSearch searchResult;
  final String searchMessage;
  final RequestStates requestStatus;

  LocationSearchState({
    this.searchResult = const LocationsSearch(
        count: 0, next: '', previous: "", results: null),
    this.searchMessage = "",
    this.requestStatus = RequestStates.empty,
  });

  LocationSearchState copyWith({
    LocationsSearch? searchResult,
    String? searchMessage,
    RequestStates? status,
  }) {
    return LocationSearchState(
      searchResult: searchResult ?? this.searchResult,
      searchMessage: searchMessage ?? this.searchMessage,
      requestStatus: status ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props =>
      [searchResult, searchMessage, requestStatus];
}
