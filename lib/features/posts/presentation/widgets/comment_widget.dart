import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_Bloc.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_event.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_event.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';
import 'package:trend/features/posts/presentation/widgets/replayComment.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/bloc_get.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_get_User/event_getU.dart';

import '../../../../shared/core/local/SharedPreferencesDemo.dart';
import '../../../../shared/utiles/routes.dart';


class CommentWidget extends StatefulWidget {
  Comment comment;
  Function replyFunction;
  CommentWidget(this.comment, this.replyFunction);
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showMore = false;

  String avatar = "http://167.71.92.176/media/profile_images/default_image.jpg";
  String replayavatar =
      "http://167.71.92.176/media/profile_images/default_image.jpg";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserAvatar();
  }

  Future<void> _loadUserAvatar() async {
    int id =
        BlocProvider.of<PostBloc>(context).id = widget.comment.authorId ?? 0;
    String Newavatar =
        await BlocProvider.of<PostBloc>(context).repository.getUserAvatar(id);

    setState(() {
      avatar = Newavatar;
    });
  }

  Future<void> _loadUserReplayAvatar(int id) async {
    String Newavatar1 =
        await BlocProvider.of<PostBloc>(context).repository.getUserAvatar(id);

    setState(() {
      replayavatar = Newavatar1;
    });
  }

  String getMentionedNamae(String content) {
    int firstSpaceIndex = content.indexOf(" ");
    if (firstSpaceIndex == -1) {
      return content;
    }
    return content.substring(0, firstSpaceIndex);
  }

  String getWithoutMentionedNamae(String content) {
    int firstSpaceIndex = content.indexOf(" ");
    if (firstSpaceIndex == -1) {
      return content;
    }
    return content.substring(firstSpaceIndex);
  }

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

  @override
  Widget build(BuildContext context) {
    String c = widget.comment.likesCount.toString() ?? 0.toString();

    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  int id = await SharedPreferencesDemo.getID();
                  if (id != widget.comment.authorId) {
                    BlocProvider.of<UserBloc>(context)
                        .add(FetchUserEvent2(widget.comment.authorId ?? 0));
                    Navigator.pushNamed(context, AppRoutes.userProfile);
                  } else {
                    BlocProvider.of<BottomNavBloc>(context)
                        .add(BottomNavItemSelected(4));
                  }
                },
                child: Networkimages(
                  size: 20,
                  imageUrl: avatar,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comment.author ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1F2232)),
                    ),
                    // SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              widget.comment.content ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.sp,
                                  color: Color(0xff9E9E9E)),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${getTimeAgoShort(DateTime.parse(widget.comment.createdAt ?? DateTime.now().toString()))}  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: Color(0xff8697AC),
                          ),
                        ),
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffE7ECF0)),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.replyFunction(widget.comment);
                          },
                          child: Text(
                            '  Reply ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Color(0xff8697AC),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Visibility(
                          visible: ((widget.comment.replies?.length != 0) &&
                              !showMore),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showMore = true;
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Color(0xffE7ECF0)),
                                    ),
                                    Text(
                                      '  View ${widget.comment.replies?.length}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp,
                                        color: Color(0xff8697AC),
                                      ),
                                    ),
                                    widget.comment.replies?.length == 1
                                        ? Text(
                                            " replie",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.sp,
                                              color: Color(0xff8697AC),
                                            ),
                                          )
                                        : Text(
                                            " replies",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.sp,
                                              color: Color(0xff8697AC),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Visibility(
                      visible: showMore,
                      child: ListView.builder(
                        shrinkWrap:
                            true, // هذا يجعل ListView يختصر حجمه ولا يشغل كل المساحة المتاحة
                        physics:
                            NeverScrollableScrollPhysics(), // هذا يجعل التمرير يقتصر على التمرير داخل الـ ListView فقط
                        itemCount:
                            widget.comment.replies?.length ?? 0, // عدد الردود
                        itemBuilder: (context, commentsIndex) {
                          Comment? reply =
                              widget.comment.replies?[commentsIndex];
                          return Replaycomment(
                            comment: widget
                                .comment, // استخدام الـ reply بدلاً من widget.comment
                            reply: reply!,
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible:
                          ((widget.comment.replies?.length != 0) && showMore),
                      child: SizedBox(
                        height: 14,
                        child: Row(
                          children: [
                            Container(
                              width: 15.w,
                              height: 1,
                              child: Divider(
                                thickness: 0.3,
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showMore = false;
                                setState(() {});
                              },
                              child: Text(
                                '  Hide ${widget.comment.replies?.length} replies',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                  color: Color(0xff8697AC),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            top: 20,
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<PostBloc>().add(LikeComment(
                          commentId: widget.comment.id ?? 0,
                          postId: widget.comment.post ?? 0));
                    },
                    child: (widget.comment.isLiked ?? false)
                        ? SvgPicture.asset(
                            "assets/icons/like_fill.svg",
                            height: 17,
                            width: 17,
                            fit: BoxFit.none,
                          ) // Filled like icon
                        : SvgPicture.asset(
                            "assets/icons/like.svg",
                            height: 17,
                            width: 17,
                            fit: BoxFit.none,
                          ),
                  ),
                  Text(
                    "${c != '0' ? c : ''}",
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 129, 129, 129),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
