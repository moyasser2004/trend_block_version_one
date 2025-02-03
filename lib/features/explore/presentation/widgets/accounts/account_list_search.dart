import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/core/enum.dart';
import '../../../data/models/local/user_details_model.dart';
import '../../manager/for_you/for_you_search_bloc.dart';
import '../../manager/for_you/for_you_search_state.dart';
import '../user_account_details.dart';

class AccountListSearch extends StatelessWidget {
  const AccountListSearch({Key? key}) : super(key: key);

  static const String defaultAvatar =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForYouSearchBloc, ForYouSearchState>(
      builder: (context, state) {
        print("State: ${state.PostRequestStatus}");

        switch (state.userRequestStatus) {
          case RequestStates.loading:
            return _buildLoadingList();
          case RequestStates.loaded:
            return _buildUserList(state);
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
                leading: Bone.circle(size: 60),
                title: Bone.text(words: 2),
                subtitle: Bone.text(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserList(ForYouSearchState state) {
    final users = state.userSearch.results?.users ?? [];

    return SliverList.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return UserAccountDetails(
          model: UserDetailsModel(
            id: "${user.id}" ,
            username: user.username ?? "Unknown",
            full_name: user.fullName ?? "No Name",
            email: user.email ?? "No Email",
            avatar: user.avatar ?? defaultAvatar,
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
