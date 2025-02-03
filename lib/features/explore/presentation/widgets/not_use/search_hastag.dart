// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:trend/features/explore/presentation/manager/explore_search_bloc.dart';
// import 'package:trend/features/explore/presentation/manager/explore_search_state.dart';
// import 'package:trend/features/explore/presentation/widgets/see_more_list_container.dart';
//
// import '../../../../shared/core/enum.dart';
// import '../../data/models/local/explor_explore_post_container_model.dart';
// import '../../data/models/local/see_more_container_model.dart';
// import 'explore_explore_post_container.dart';
//
// class SearchHastag extends StatelessWidget {
//   const SearchHastag({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ExploreSearchBloc, ExploreSearchState>(
//       builder: (context, state) {
//         switch (state.status) {
//           case RequestStates.loading:
//             return const SliverToBoxAdapter(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           case RequestStates.loaded:
//             return ListView.builder(
//                 itemCount: state.searchResult.hashtags.length,
//                 itemBuilder: (context, index) {
//                   final hashtag = state.searchResult.hashtags[index];
//                   return  Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     elevation: 0,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12), // Rounded corners for the card
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.all(15), // Padding inside ListTile
//                       title: Row(
//                         children: [
//                           Icon(
//                             // Conditional icon based on whether the hashtag is trending
//                             hashtag.isTrending! ? Icons.trending_up : Icons.tag,
//                             color: hashtag.isTrending! ? Colors.green : Colors.grey,
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             hashtag.isTrending! ? 'Trending' : hashtag.name!,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                       subtitle: Row(
//                         children: [
//                           Icon(
//                             Icons.access_time,
//                             size: 18,
//                             color: Colors.grey[600],
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             "${hashtag.createdAt}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                       trailing: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "${hashtag.postsCount}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             "Posts",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//
//           case RequestStates.error:
//             return SliverToBoxAdapter(
//               child: SizedBox(
//                 height: 400,
//                 child: Center(
//                   child: Text(state.searchMessage),
//                 ),
//               ),
//             );
//         }
//       },
//     );
//   }
// }
