import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_Bloc.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_event.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/presentation/widgets/post_details.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_get_User/bloc_get.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_get_User/event_getU.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';

import '../../../../shared/core/local/SharedPreferencesDemo.dart';
import '../../../../shared/utiles/routes.dart';

class HeaderPost extends StatelessWidget {
  final PostModel post;
  HeaderPost({super.key, required this.post});
  String getTimeAgoShort(DateTime createdAt) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d'; // e.g. "1 d"
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h'; // e.g. "5 h"
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m'; // e.g. "10 m"
    } else {
      return '${difference.inSeconds}s'; // e.g. "30 s"
    }
  }

  bool isMe = false;
  bool is_vervied = false;
  @override
  Widget build(BuildContext context) {
    String timeAgo = getTimeAgoShort(post.createdAt);

    isMe = SharedPreferencesDemo.loadUserData().id == post.authorId;
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        int id = await SharedPreferencesDemo.getID();
                        if (id != post.authorId) {
                          BlocProvider.of<UserBloc>(context)
                              .add(FetchUserEvent2(
                            post.authorId ?? 0,
                          ));
                          Navigator.pushNamed(context, AppRoutes.userProfile);
                        } else {
                          int c = await SharedPreferencesDemo.getID();

                          BlocProvider.of<ProfileBloc>(context)
                              .add(getPostForUserevent(id: c));

                          BlocProvider.of<BottomNavBloc>(context)
                              .add(BottomNavItemSelected(4));
                        }
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.transparent,
                        child: CachedNetworkImage(
                          imageUrl: post.avatar ??
                              "http://167.71.92.176/media/profile_images/default_image.jpg", // رابط الصورة
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            backgroundImage: imageProvider, // الصورة المحمّلة
                          ),
                          placeholder: (context, url) => CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage(
                                'assets/images/avatar.jpg'), // صورة أثناء التحميل
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage(
                                'assets/images/avatar.jpg'), // صورة في حال الخطأ
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        int id = await SharedPreferencesDemo.getID();
                        if (id != post.authorId) {
                          BlocProvider.of<UserBloc>(context)
                              .add(FetchUserEvent2(post.authorId ?? 0));
                          Navigator.pushNamed(context, AppRoutes.userProfile);
                        } else {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          int c = await int.parse(
                              sharedPreferences.getString('id')!);

                          BlocProvider.of<ProfileBloc>(context)
                              .add(getPostForUserevent(id: c));

                          BlocProvider.of<BottomNavBloc>(context)
                              .add(BottomNavItemSelected(4));
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.author ??
                                'Unknown Author', // Fallback if author is null
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Visibility(
                      visible: is_vervied,
                      child: Icon(
                        Icons.verified,
                        size: 12.h,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      timeAgo,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return PostDetails(
                              post: post,
                              isMe: isMe,
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                        size: 19,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
