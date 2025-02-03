import 'package:equatable/equatable.dart';
import 'package:trend/features/explore/domain/entities/hashtags_search.dart';

import '../../../../../shared/core/enum.dart';

class HashtagsSearchState extends Equatable {
  final SearchHashtags searchResult;
  final String searchMessage;
  final RequestStates requestStatus;

  HashtagsSearchState({
    this.searchResult = const SearchHashtags(hashtags: []),
    this.searchMessage = "",
    this.requestStatus = RequestStates.empty,
  });

  HashtagsSearchState copyWith({
    SearchHashtags? searchResult,
    String? searchMessage,
    RequestStates? status,
  }) {
    return HashtagsSearchState(
      searchResult: searchResult ?? this.searchResult,
      searchMessage: searchMessage ?? this.searchMessage,
      requestStatus: status ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props =>
      [searchResult, searchMessage, requestStatus];
}
