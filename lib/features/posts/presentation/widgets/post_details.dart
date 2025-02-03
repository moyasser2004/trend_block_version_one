import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/posts/bloc/Bloc_Current_user/Current%20_user_Bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_Current_user/Current%20_user_event.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_event.dart';
import 'package:trend/features/posts/data/models/post_model.dart';

import '../../../../shared/core/local/SharedPreferencesDemo.dart';

class PostDetails extends StatelessWidget {
  final PostModel post;
  final bool isMe;
  const PostDetails({super.key, required this.post, this.isMe = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // Ensure it takes only necessary space
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 13.h, bottom: 5.h),
                child: Text(
                  'Post Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 5.h, bottom: 35.h),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(15.h),
                        child: isMe
                            ? GestureDetector(
                                onTap: () async {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  int c = await int.parse(sharedPreferences
                                      .getString('totalPosts')!);

                                  c--;
                                  bool x = await sharedPreferences.setString(
                                      'totalPosts', c.toString());
                                  int id = await SharedPreferencesDemo.getID();
                                  Navigator.of(context).pop();
                                  context
                                      .read<PostBloc>()
                                      .add(AddDeletePostEvent(post.id ?? 0));
                                  BlocProvider.of<CurrentUserBloc>(context)
                                      .add(GetPostForCurrentUserEvent(id: id));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 1.h),
                                  child: Row(children: [
                                    Icon(
                                      Icons.delete_outline,
                                      size: 14.h,
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      children: [
                                        Text(
                                          'Delete Post',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 1.h),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/icons/hide_post.svg',
                                        height: 14.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        children: [
                                          Text(
                                            'Hide Post',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: 0.2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      context.read<PostBloc>().add(
                                          AddBlocUserEvent(post.authorId ?? 0));
                                    },
                                    child: Row(children: [
                                      Icon(
                                        Icons.block_rounded,
                                        color: Colors.red,
                                        size: 14.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        children: [
                                          Text(
                                            'Block User',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                      ))
                ],
              ),
            ),
          ]),
    );
  }
}
