import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trend/features/explore/data/models/local/user_details_model.dart';
import '../../../../../shared/const/colors.dart';
import '../../../../../shared/core/enum.dart';
import '../../manager/for_you/for_you_search_bloc.dart';
import '../../manager/for_you/for_you_search_state.dart';
import '../user_account_details.dart';

class ExploreListSearch extends StatelessWidget {
  const ExploreListSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ExploreListSearch Build");
    return BlocBuilder<ForYouSearchBloc, ForYouSearchState>(
      builder: (context, state) {
        switch (state.userRequestStatus) {
          case RequestStates.loading:
          case RequestStates.empty:
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildSkeletonItem(),
                childCount: 4,
              ),
            );
          case RequestStates.loaded:
            final users = state.userSearch.results?.users ?? [];
            final itemCount = users.length > 4 ? 4 : users.length;
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final user = users[index];
                  return UserAccountDetails(
                    model: UserDetailsModel(
                      id: "${user.id}",
                      username: user.username ?? "",
                      full_name: user.fullName ?? "",
                      email: user.email ?? "",
                      avatar: user.avatar ??
                          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
                    ),
                  );
                },
                childCount: itemCount,
              ),
            );
          case RequestStates.error:
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Text(state.searchMessage),
                ),
              ),
            );
        }
      },
    );
  }

  Widget _buildSkeletonItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Skeletonizer.zone(
        effect: ShimmerEffect(
          duration: const Duration(milliseconds: 1500),
          baseColor: Color(AppColors.greyLight),
          highlightColor: Color(AppColors.white),
        ),
        child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          color: Color(AppColors.white),
          child: ListTile(
            leading: Bone.circle(size: 60),
            title: Bone.text(words: 2),
            subtitle: Bone.text(),
          ),
        ),
      ),
    );
  }
}
