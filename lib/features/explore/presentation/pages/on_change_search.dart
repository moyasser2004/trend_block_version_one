import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../shared/const/colors.dart';
import '../../../../shared/core/enum.dart';
import '../../../../shared/style/app_styles.dart';
import '../../../../shared/utiles/routes.dart';
import '../../../../shared/utiles/services_local.dart';
import '../../data/models/local/user_details_model.dart';
import '../manager/for_you/for_you_search_bloc.dart';
import '../manager/for_you/for_you_search_event.dart';
import '../manager/for_you/for_you_search_state.dart';
import '../manager/hashtags/hashtags_bloc.dart';
import '../manager/location/location_bloc.dart';
import '../widgets/user_account_details.dart';
import 'explore_search.dart';

class OnChangeSearch extends StatefulWidget {
  const OnChangeSearch({Key? key}) : super(key: key);

  @override
  State<OnChangeSearch> createState() => _OnChangeSearchState();
}

class _OnChangeSearchState extends State<OnChangeSearch> {
  late TextEditingController _searchController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      context.read<ForYouSearchBloc>().add(
            UserSearchEvent(_searchController.text.trim()),
          );
    }
  }

  void _navigateToExploreSearch() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) => MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => ForYouSearchBloc(
                    searchExploreUseCase: sl(), userSearchUseCase: sl())),
            BlocProvider(create: (_) => HashtagsBloc(hashtagsUseCase: sl())),
            BlocProvider(
                create: (_) =>
                    LocationSearchesBloc(locationSearchUseCase: sl())),
          ],
          child: ExploreSearchPage(search: _searchController.text),
        ),
        transitionDuration: Duration.zero,
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(AppColors.greyLight)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.white),
      appBar: _buildAppBar(),
      body: const CustomScrollView(slivers: [OnChangeSearchUserList()]),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          child: Row(
            children: [
              Flexible(
                child: FittedBox(
                  child: IconButton(
                    onPressed: () => Navigator.canPop(context)
                        ? Navigator.pushNamed(context, AppRoutes.home)
                        : null,
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 20, color: Color(AppColors.black)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 7,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (_) => _onSearchChanged(),
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      prefixIcon: const Icon(FontAwesomeIcons.search,
                          size: 16, color: Colors.black),
                      hintText: 'Search',
                      hintStyle: AppStyles.styleNormal13
                          .copyWith(color: const Color(AppColors.greyDark)),
                      fillColor:
                          const Color(AppColors.greyLighter).withOpacity(0.2),
                      filled: true,
                      border: _buildOutlineInputBorder(),
                      enabledBorder: _buildOutlineInputBorder(),
                      focusedBorder: _buildOutlineInputBorder(),
                    ),
                    onEditingComplete: _navigateToExploreSearch,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnChangeSearchUserList extends StatelessWidget {
  const OnChangeSearchUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForYouSearchBloc, ForYouSearchState>(
      builder: (context, state) {
        switch (state.userRequestStatus) {
          case RequestStates.loading:
            return _buildLoadingSkeleton();
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

  Widget _buildLoadingSkeleton() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Skeletonizer.zone(
            effect: ShimmerEffect(
              duration: const Duration(milliseconds: 1500),
              baseColor: const Color(AppColors.greyLight),
              highlightColor: const Color(AppColors.white),
            ),
            child: const Card(
              color: Color(AppColors.white),
              margin: EdgeInsets.zero,
              elevation: 0,
              child: ListTile(
                leading: Bone.circle(size: 60),
                title: Bone.text(words: 2),
                subtitle: Bone.text(),
              ),
            ),
          ),
        ),
        childCount: 12,
      ),
    );
  }

  Widget _buildUserList(ForYouSearchState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          final user = state.userSearch.results?.users[index];
          return UserAccountDetails(
            model: UserDetailsModel(
              id: "${user?.id ?? ""}",
              username: user?.username ?? "",
              full_name: user?.fullName ?? "",
              email: user?.email ?? "",
              avatar: user?.avatar ??
                  "https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
            ),
          );
        },
        childCount: state.userSearch.results?.users.length ?? 0,
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return SliverToBoxAdapter(
      child: SizedBox(height: 200, child: Center(child: Text(message))),
    );
  }
}
