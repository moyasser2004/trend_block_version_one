// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProfileWidgetsetting extends StatelessWidget {
//   final Icon icon;
//   final String title;
//   final String value;
//   final bool showDivider;

//   const ProfileWidgetsetting(
//       {super.key,
//       required this.icon,
//       required this.title,
//       this.showDivider = false,
//       required this.value});
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       alignment: Alignment.center,
//       margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               title,
//               style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Text(
//                           value,
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             // overflow: TextOverflow.ellipsis,
//                           ),
//                           maxLines: 1,
//                         ),
//                       ),
//                     ),
//                     // Spacer(),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 12.sp,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//                 showDivider
//                     ? SizedBox(
//                         width: double.infinity,
//                         child: Divider(
//                           color: Colors.black.withOpacity(0.1),
//                         ),
//                       )
//                     : SizedBox.shrink(),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
