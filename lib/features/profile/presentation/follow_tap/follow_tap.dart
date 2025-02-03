// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class FollowTabs extends StatefulWidget {
//   final int initialTabIndex; // 0 for Followers, 1 for Following

//   const FollowTabs({super.key, required this.initialTabIndex});

//   @override
//   State<FollowTabs> createState() => _FollowTabsState();
// }

// class _FollowTabsState extends State<FollowTabs>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: 2,
//       vsync: this,
//       initialIndex: widget.initialTabIndex, // Set initial tab index
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           'sara',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context); // Navigate back
//           },
//         ),
//         bottom: TabBar(
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.black,
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Followers'),
//             Tab(text: 'Following'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Followers List
//           Center(
//             child: ListView.builder(
//               itemCount: 10, // Replace with dynamic count
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: AssetImage('assets/images/ppl.jpg'),
//                   ),
//                   title: Text(
//                     'ali',
//                     style:
//                         TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
//                   ),
//                   trailing: Container(
//                     height: 25.h,
//                     width: 70.w,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 0, 0, 0),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text('Message',
//                         style: TextStyle(
//                             fontSize: 11.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Following List
//           Center(
//             child: ListView.builder(
//               itemCount: 8, // Replace with dynamic count
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: AssetImage('assets/images/field.jpg'),
//                   ),
//                   title: Text(
//                     'mohammed',
//                     style:
//                         TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
//                   ),
//                   trailing: Container(
//                     height: 25.h,
//                     width: 70.w,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 226, 17, 17),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text('Unfollow',
//                         style: TextStyle(
//                             fontSize: 11.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
