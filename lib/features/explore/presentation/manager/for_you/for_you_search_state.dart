import 'package:equatable/equatable.dart';
import 'package:trend/features/explore/domain/entities/user_search.dart';

import '../../../../../shared/core/enum.dart';
import '../../../domain/entities/for_you_search.dart';

class ForYouSearchState extends Equatable {
  final PostSearch postSearchResult;
  final String searchMessage;
  final RequestStates PostRequestStatus;

  final UserSearch userSearch;
  final String userSearchMessage;
  final RequestStates userRequestStatus;

  ForYouSearchState({
    this.postSearchResult = const PostSearch(count: null, next: '', previous: null, results: null),
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
      postSearchResult: searchResult ?? this.postSearchResult,
      searchMessage: searchMessage ?? this.searchMessage,
      PostRequestStatus: status ?? this.PostRequestStatus,
      userSearch: userSearch ?? this.userSearch,
      userSearchMessage: userSearchMessage ?? this.userSearchMessage,
      userRequestStatus: userStatus ?? this.userRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        postSearchResult,
        searchMessage,
        PostRequestStatus,
        userSearch,
        userSearchMessage,
        userRequestStatus
      ];
}
