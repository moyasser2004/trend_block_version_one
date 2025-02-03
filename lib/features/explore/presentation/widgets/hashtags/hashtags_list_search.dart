import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trend/features/explore/data/models/local/hashtags_details.dart';
import 'package:trend/features/explore/presentation/manager/hashtags/hashtags_state.dart';

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/core/enum.dart';
import '../../manager/hashtags/hashtags_bloc.dart';
import 'hashtags_container.dart';

class HashtagsListSearch extends StatelessWidget {
  const HashtagsListSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HashtagsBloc, HashtagsSearchState>(
      builder: (context, state) {
        print("State Request Status: ${state.requestStatus}");

        switch (state.requestStatus) {
          case RequestStates.loading:
            return _buildLoadingList();
          case RequestStates.loaded:
            return _buildHashtagList(state);
          case RequestStates.error:
            return _buildErrorMessage(state.searchMessage);
          case RequestStates.empty:
            return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }

  Widget _buildLoadingList() {
    return SliverList.builder(
      itemCount: 9, // Instagram-style skeleton placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Skeletonizer.zone(
            effect: ShimmerEffect(
              duration: const Duration(milliseconds: 1500),
              baseColor: Color(AppColors.greyLight),
              highlightColor: Color(AppColors.white),
            ),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: Color(AppColors.white),
              child: const ListTile(
                leading: Icon(
                  FontAwesomeIcons.hashtag,
                  color: Color(AppColors.greyDark),
                ),
                title: Bone.text(words: 2),
                subtitle: Bone.text(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHashtagList(HashtagsSearchState state) {
    final hashtags = state.searchResult.hashtags ?? [];

    return SliverList.builder(
      itemCount: hashtags.length,
      itemBuilder: (context, index) {
        final hashtag = hashtags[index];

        return HashtagsContainer(
          model: HashtagsDetailsModel(
            author: hashtag.name ?? "Unknown",
            author_id: "${hashtag.id }",
            created_at: "${hashtag.createdAt}",
            posts_count: hashtag.postsCount?.toString() ?? "0",
          ),
        );
      },
    );
  }

  Widget _buildErrorMessage(String message) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Center(child: Text(message)),
      ),
    );
  }
}
