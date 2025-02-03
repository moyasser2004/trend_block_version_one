// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trend/shared/style/app_styles.dart';
// import 'package:trend/shared/utiles/routes.dart';
// import '../../data/models/local/explore_main_container_model.dart';
//
// class ExploreMainContainer extends StatelessWidget {
//   const ExploreMainContainer(
//       {Key? key, required this.model, this.text = true})
//       : super(key: key);
//
//   final ExploreMainContainerModel model;
//   final bool text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: model.index != 0 ? 10.0 : 0.0),
//       child: AspectRatio(
//         aspectRatio: 1 / 1.3,
//         child: InkWell(
//             onTap: () {
//            //   Navigator.pushNamed(context, AppRoutes.trendDetails);
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   child: Image.asset(
//                     height: 120.h,
//                     model.imgUrl,
//                     fit: BoxFit.fill,
//                   ),
//                   // CachedNetworkImage(
//                   //   width: 120.0,
//                   //   fit: BoxFit.cover,
//                   //   imageUrl:
//                   //   AppLinks.imageUrl(movie.backdropPath),
//                   //   placeholder: (context, url) =>
//                   //       Shimmer.fromColors(
//                   //         baseColor: Colors.grey[850]!,
//                   //         highlightColor: Colors.grey[800]!,
//                   //         child: Container(
//                   //           height: 170.0,
//                   //           width: 120.0,
//                   //           decoration: BoxDecoration(
//                   //             color: Colors.black,
//                   //             borderRadius:
//                   //             BorderRadius.circular(10.0),
//                   //           ),
//                   //         ),
//                   //       ),
//                   //   errorWidget: (context, url, error) =>
//                   //   const Icon(Icons.error),
//                   // ),
//                 ),
//                 Visibility(
//                     visible: text,
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         "#hsdahshdjg",
//                         style: AppStyles.styleBold12,
//                       ),
//                     ))
//               ],
//             )),
//       ),
//     );
//   }
// }
