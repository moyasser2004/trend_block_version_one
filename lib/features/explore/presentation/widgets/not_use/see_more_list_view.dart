// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trend/features/explore/presentation/widgets/see_more_list_container.dart';
// import '../../data/models/local/see_more_container_model.dart';
//
//
// class SeeMoreListView extends StatelessWidget {
//   const SeeMoreListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: SizedBox(
//           height: 150.h,
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return SeeMoreListContainer(
//                       model: SeeMoreContainerModel(
//                         imgUrl: 'assets/images/football.jpg',
//                       ),
//                     );
//                   },
//                   itemCount: 10,
//                   shrinkWrap: true,
//                 ),
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return SeeMoreListContainer(
//                       model: SeeMoreContainerModel(
//                         imgUrl: 'assets/images/football.jpg',
//                       ),
//                     );
//                   },
//                   itemCount: 10,
//                   shrinkWrap: true,
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
