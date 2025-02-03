import 'package:equatable/equatable.dart';
import 'package:trend/features/explore/domain/entities/all_post.dart';
import '../../../../../shared/core/enum.dart';

class ExploreState extends Equatable {
  final AllPost allPost;
  final String getExploreAllPostMessage;
  final RequestStates requestStatus;

  const ExploreState({
    this.allPost = const AllPost(next: '', previous: null, count: null, results: []),
    this.getExploreAllPostMessage = "",
    this.requestStatus = RequestStates.loading,
  });

  ExploreState copyWith({
    AllPost? allPost,
    String? getExploreAllPostMessage,
    RequestStates? requestStatus,
  }) {
    return ExploreState(
      allPost: allPost ?? this.allPost,
      getExploreAllPostMessage: getExploreAllPostMessage ?? this.getExploreAllPostMessage,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  ExploreState appendPosts(AllPost newPosts) {
    return copyWith(
      allPost: AllPost(
        next: newPosts.next,
        previous: newPosts.previous,
        count: newPosts.count,
        results: [...allPost.results, ...newPosts.results], // Merge old and new results
      ),
    );
  }

  @override
  List<Object?> get props => [allPost, getExploreAllPostMessage, requestStatus];
}