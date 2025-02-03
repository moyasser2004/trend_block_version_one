// import 'package:flutter/material.dart';
// import 'package:flutter_fadein/flutter_fadein.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trend/features/explore/presentation/widgets/explore_main_container.dart';
//
// import '../../data/models/local/explore_main_container_model.dart';
//
// class ExploreTrendingListView extends StatelessWidget {
//   const ExploreTrendingListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeIn(
//         duration: const Duration(milliseconds: 500),
//         child: SizedBox(
//             height: 160.0.h,
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return ExploreMainContainer(
//                   text: true,
//                     model: ExploreMainContainerModel(
//                         imgUrl: 'assets/images/aziz.jpg',
//                         index: index));
//               },
//             )));
//   }
// }
