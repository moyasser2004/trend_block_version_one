import 'package:equatable/equatable.dart';
import 'package:trend/features/explore/domain/entities/user_search.dart';

import '../../../../../shared/core/enum.dart';
import '../../../domain/entities/for_you_search.dart';

class ForYouSearchState extends Equatable {
  final PostSearch searchResult;
  final String searchMessage;
  final RequestStates PostRequestStatus;

  final UserSearch userSearch;
  final String userSearchMessage;
  final RequestStates userRequestStatus;

  ForYouSearchState({
    this.searchResult = const PostSearch(
        count: 0, next: "", previous: "", results: null),
    this.searchMessage = "",
    this.PostRequestStatus = RequestStates.empty,
    this.userSearch = const UserSearch(
        count: 0, next: "", previous: "", results: null),
    this.userSearchMessage = "",
    this.userRequestStatus = RequestStates.empty,
  });

  ForYouSearchState copyWith({
    PostSearch? searchResult,
    String? searchMessage,
    RequestStates? status,
    UserSearch? userSearch,
    String? userSearchMessage,
    RequestStates? userStatus,
  }) {
    return ForYouSearchState(
      searchResult: searchResult ?? this.searchResult,
      searchMessage: searchMessage ?? this.searchMessage,
      PostRequestStatus: status ?? this.PostRequestStatus,
      userSearch: userSearch ?? this.userSearch,
      userSearchMessage: userSearchMessage ?? this.userSearchMessage,
      userRequestStatus: userStatus ?? this.userRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        searchResult,
        searchMessage,
        PostRequestStatus,
        userSearch,
        userSearchMessage,
        userRequestStatus
      ];
}
