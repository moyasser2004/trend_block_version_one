import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart'; // For Instagram-like animation

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/core/enum.dart';
import '../../../data/models/local/explor_explore_post_container_model.dart';
import '../../../domain/entities/for_you_search.dart';
import '../../manager/for_you/for_you_search_bloc.dart';
import '../../manager/for_you/for_you_search_state.dart';
import '../../pages/user_search_posts.dart';
import 'explore_explore_post_container.dart';

class ExploreSearchForYouPost extends StatelessWidget {
  const ExploreSearchForYouPost({Key? key}) : super(key: key);

  static const String defaultImage =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9nJ_3Dmrsxec-D2q43IRnN7ntGIRa4qO8qXONXdxzdX053t3OUSivYJoBr-uSTpOVEcY&usqp=CAU";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForYouSearchBloc, ForYouSearchState>(
      builder: (context, state) {
        switch (state.PostRequestStatus) {
          case RequestStates.loading:
            return _buildLoadingGrid();
          case RequestStates.loaded:
            return _buildLoadedGrid(state);
          case RequestStates.error:
            return _buildErrorMessage(state.searchMessage);
          case RequestStates.empty:
            return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }

  Widget _buildLoadingGrid() {
    return SliverGrid.builder(
      itemCount: 9, // Instagram-style skeleton placeholders
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Color(AppColors.greyLight),
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(color: Color(AppColors.greyLighter)),
          ),
        );
      },
    );
  }

  Widget _buildLoadedGrid(ForYouSearchState state) {
    final users = state.postSearchResult.results?.users ?? [];

    return SliverGrid.builder(
      itemCount: users.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final user = state.postSearchResult.results?.users[index];

        final randomImage = (user?.recentPosts.isNotEmpty == true)
            ? user!.recentPosts.first.image
            : null;

        final List<RecentPost>? userPosts =
            state.postSearchResult.results?.users[index].recentPosts;

        return InkWell(
            child: ExploreExplorePostContainer(
                model: ExplorExplorePostContainerModel(
              imgUrl: randomImage ?? defaultImage,
            )),
            onTap: () {
              if (userPosts == null || userPosts.isEmpty) {
                return;
              }
              print("User clicked");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserSearchPostsPage(
                            posts: userPosts,
                            search: "Posts",
                          )));
            });
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
