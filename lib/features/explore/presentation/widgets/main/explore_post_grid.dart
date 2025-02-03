import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trend/features/explore/data/models/local/explor_explore_post_container_model.dart';
import 'package:trend/features/explore/presentation/manager/explore/explore_state.dart';
import 'package:trend/features/explore/presentation/widgets/for_you/explore_explore_post_container.dart';
import '../../../../../shared/const/colors.dart';
import '../../../../../shared/core/enum.dart';
import '../../manager/explore/explore_bloc.dart';
import '../../manager/explore/explore_event.dart';

class ExplorePostGrid extends StatefulWidget {
  const ExplorePostGrid({Key? key}) : super(key: key);

  @override
  _ExplorePostGridState createState() => _ExplorePostGridState();
}

class _ExplorePostGridState extends State<ExplorePostGrid> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false; // To prevent multiple API calls

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      // User has reached the bottom of the list
      setState(() {
        _isLoadingMore = true; // Prevent multiple API calls
      });

      print('Loading more posts'); // Debugging
      // Trigger the event to load more posts
      context.read<ExploreBloc>().add(GetPostWithPageNumberEvent());

      // Reset the loading flag after a delay (optional)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        switch (state.requestStatus) {
          case RequestStates.loading:
            return GridView.builder(
              shrinkWrap: true,
              itemCount: 15, // Instagram-style skeleton placeholders
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Color(AppColors.greyLight),
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(AppColors.greyLighter)
                    ),
                  ),
                );
              },
            );
          case RequestStates.loaded:
            return GridView.builder(
              shrinkWrap: true,
              controller: _scrollController, // Attach the ScrollController
              physics: const BouncingScrollPhysics(),
              itemCount: state.allPost.results.length + 1, // +1 for the loading indicator
              itemBuilder: (context, index) {
                if (index >= state.allPost.results.length) {
                  // Show a loading indicator at the bottom
                  if (state.allPost.results.length  % 2 == 0){
                    return Shimmer.fromColors(
                      baseColor: Color(AppColors.greyLight),
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(AppColors.greyLighter)
                        ),
                      ),
                    );
                  }else{
                    return Shimmer.fromColors(
                      baseColor: Color(AppColors.greyLight),
                      highlightColor: Color(AppColors.greyDark),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(AppColors.greyLighter)
                        ),
                      ),
                    ); 
                  }
                }

                final post = state.allPost.results[index];
                final model = ExplorExplorePostContainerModel(
                  imgUrl: post.image != null
                      ? post.image
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9nJ_3Dmrsxec-D2q43IRnN7ntGIRa4qO8qXONXdxzdX053t3OUSivYJoBr-uSTpOVEcY&usqp=CAU",
                );

                return SizedBox(
                  height: (index % 5 == 0) ? 200 : 120, // Randomized height
                  width: (index % 3 == 0) ? double.infinity : null, // Full-width items
                  child: ExploreExplorePostContainer(model: model),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
            );
          case RequestStates.error:
            return Center(
              child: Text(state.getExploreAllPostMessage),
            );
          case RequestStates.empty:
            return const Center(
              child: Text('No posts available'),
            );
        }
      },
    );
  }
}