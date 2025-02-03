// import 'package:flutter/cupertino.dart';
// import 'package:flutter_fadein/flutter_fadein.dart';
//
// import '../../data/models/local/explore_main_container_model.dart';
// import 'explore_main_container.dart';
//
//
// class ExploreTrendingListView extends StatelessWidget {
//   const ExploreTrendingListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeIn(
//         duration: const Duration(milliseconds: 500),
//         child: SizedBox(
//             height: 160.0,
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return ExploreMainContainer(
//                     model: ExploreMainContainerModel(
//                         imgUrl: 'assets/images/aziz.jpg',
//                         index: index));
//               },
//             )));
//   }
// }