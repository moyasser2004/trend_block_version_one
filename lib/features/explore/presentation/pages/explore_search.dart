import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/explore/presentation/manager/location/location_event.dart';
import 'package:trend/features/explore/presentation/pages/account_search.dart';
import 'package:trend/shared/const/colors.dart';
import '../manager/for_you/for_you_search_bloc.dart';
import '../manager/for_you/for_you_search_event.dart';
import '../manager/hashtags/hashtags_bloc.dart';
import '../manager/hashtags/hashtags_event.dart';
import '../manager/location/location_bloc.dart';
import '../manager/tap_bar/explore_search_tap_bar_bloc.dart';
import '../manager/tap_bar/explore_search_tap_bar_event.dart';
import '../manager/tap_bar/explore_search_tap_bar_state.dart';
import '../widgets/main/explore_search_app_bar.dart';
import 'for_you_search.dart';
import 'hastags_search.dart';
import 'location_search.dart';

class ExploreSearchPage extends StatefulWidget {
  final String search;

  const ExploreSearchPage({super.key, required this.search});

  @override
  _ExploreSearchPageState createState() => _ExploreSearchPageState();
}

class _ExploreSearchPageState extends State<ExploreSearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.search);
    _tabController = TabController(length: 5, vsync: this);
    _initializeSearch();
    _tabController.addListener(_handleTabChange);
  }

  /// Initialize search if input is not empty
  void _initializeSearch() {
    final searchQuery = widget.search.trim();
    if (searchQuery.isNotEmpty) {
      context.read<ForYouSearchBloc>()
        ..add(PostSearchEvent(searchQuery))
        ..add(UserSearchEvent(searchQuery));
    }
  }

  /// Handles tab changes and triggers corresponding search events
  void _handleTabChange() {
    if (!_tabController.indexIsChanging) return;

    context.read<TabBloc>().add(TabChanged(_tabController.index));

    final searchQuery = _textController.text.trim();
    if (searchQuery.isNotEmpty) {
      switch (_tabController.index) {
        case 1:
          context.read<ForYouSearchBloc>().add(UserSearchEvent(searchQuery));
          break;
        case 2:
          context.read<HashtagsBloc>().add(HashtagsEvent(searchQuery));
          break;
        case 3:
          context.read<LocationSearchesBloc>().add(LocationEvent(searchQuery));
          break;
        case 4:
          print('Real tab selected'); // Handle "Real" tab search logic here
          break;
      }
    }
  }

  /// Handles search button press
  void _handleSearch() {
    final searchQuery = _textController.text.trim();
    if (searchQuery.isEmpty) return;

    switch (_tabController.index) {
      case 0:
        context.read<ForYouSearchBloc>()
          ..add(PostSearchEvent(searchQuery))
          ..add(UserSearchEvent(searchQuery));
        break;
      case 1:
        context.read<ForYouSearchBloc>().add(UserSearchEvent(searchQuery));
        break;
      case 2:
        context.read<HashtagsBloc>().add(HashtagsEvent(searchQuery));
        break;
      case 3:
        context.read<LocationSearchesBloc>().add(LocationEvent(searchQuery));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.white),
      appBar: ExploreSearchAppBar(
        onSearchPressed: _handleSearch,
        textController: _textController,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  /// Builds the tab bar UI
  Widget _buildTabBar() {
    return TabBar(
      tabAlignment: TabAlignment.start,
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Colors.black,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: 'For You'),
        Tab(text: 'Accounts'),
        Tab(text: 'Hashtags'),
        Tab(text: 'Location'),
        Tab(text: 'Real'),
      ],
    );
  }

  /// Builds the tab content with IndexedStack for efficiency
  Widget _buildTabContent() {
    return BlocListener<TabBloc, TabState>(
      listener: (context, state) => _tabController.animateTo(state.selectedIndex),
      child: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.selectedIndex,
            children: const [
              ExploreSearchForYou(),
              SearchAccounts(),
              HashtagsSearch(),
              LocationSearch(),
              Center(child: Text('Reals')),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }
}
