import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/notifications/bloc/notification_bloc.dart';
import 'package:trend/features/notifications/presentation/LotificationList.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<bool> isFollowing = []; // حالة زر المتابعة لكل إشعار

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('No notifications available.'));
            }

            if (isFollowing.length != state.notifications.length) {
              isFollowing =
                  List.generate(state.notifications.length, (index) => false);
            }
            return NotificationList(notifications: state.notifications);
          } else if (state is NotificationError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text('No notifications available.'));
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
//**
//
//
// */
// class _NotificationsState extends State<Notifications> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Notifications',
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: Color(0xff000000)),
//         ),
//       ),
//       body: BlocConsumer<NotificationBloc, NotificationState>(
//         builder: (context, state) {
//           if (state is NotificationLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is NotificationLoaded) {
//             if (state.notifications.isEmpty) {
//               return const Center(child: Text('No notifications available.'));
//             }

//             return ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: state.notifications.length,
//                 itemBuilder: (context, index) {
//                   bool follow;
//                   // bool isfollwing =
//                   //     state.notifications[index].verb.contains("following you");
//                   return Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             CircleAvatar(
//                               radius: 18,
//                               backgroundColor: Colors.transparent,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   BlocProvider.of<UserBloc>(context).add(
//                                       FetchUserEvent2(
//                                           state.notifications[index].id_actor ??
//                                               0));
//                                   Navigator.pushNamed(
//                                       context, AppRoutes.userProfile);
//                                 },
//                                 child: ClipOval(
//                                     child: Networkimages(
//                                   imageUrl: state.notifications[index].avatar ??
//                                       "http://167.71.92.176/media/profile_images/default_image.jpg",
//                                   size: 50.r,
//                                 )),
//                               ),
//                             ),
//                             Visibility(
//                                 visible: !state.notifications[index].verb
//                                     .contains("following you"),
//                                 child: Positioned(
//                                     top: 25,
//                                     left: 20,
//                                     child: GetIconForNotification(
//                                         state.notifications[index].verb)))
//                           ],
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Actorandtime(
//                                 Actor: state.notifications[index].actor,
//                                 createdAt:
//                                     state.notifications[index].createdAt),
//                             Notificatioverb(
//                               verb: state.notifications[index].verb,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Visibility(
//                               visible: state.notifications[index].verb
//                                   .contains("following you"),
//                               child: Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       BlocProvider.of<FollowingBloc>(context)
//                                           .add(FollowUserEvent(state
//                                               .notifications[index].id_actor));
//                                     },
//                                     child: BlocListener<FollowingBloc,
//                                         FollowingState>(
//                                       listener: (context, state) {
//                                         print(state);
//                                         if (state is FollowingSuccess) {
//                                           follow = false;
//                                         }
//                                       },
//                                       child: Visibility(
//                                         visible: state.notifications[index].verb
//                                             .contains("following you"),
//                                         child: Container(
//                                           height: 34,
//                                           width: 112,
//                                           decoration: BoxDecoration(
//                                               color: Color(0xff000000),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10))),
//                                           child: Center(
//                                             child: Text(
//                                               "Follow Back",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w400),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Container(
//                                       height: 34,
//                                       width: 103,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xffF9F9FC),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10))),
//                                       child: Center(
//                                         child: Text(
//                                           "Remove",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Removeicon()
//                       ],
//                     ),
//                   );
//                 });
//           } else if (state is NotificationError) {
//             return Center(child: Text(state.errorMessage));
//           } else {
//             return const Center(child: Text('No notifications available.'));
//           }
//         },
//         listener: (context, state) {},
//       ),
//     );
//   }
// }
