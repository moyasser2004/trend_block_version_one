import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_Bloc.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_event.dart';
import 'package:trend/features/posts/data/models/CommentModel.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';
import 'package:trend/features/posts/presentation/widgets/commentContent.dart';
import 'package:trend/features/posts/presentation/widgets/replayComment.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_get_User/bloc_get.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_get_User/event_getU.dart';
import 'package:trend/shared/core/local/SharedPreferencesDemo.dart';
import 'package:trend/shared/utiles/profile_helper.dart';
import 'package:trend/shared/utiles/routes.dart';

class CustomCommentBody extends StatefulWidget {
  const CustomCommentBody(
      {super.key, required this.comment, required this.replyFunction});
  final Comment comment;
  final Function replyFunction;

  @override
  State<CustomCommentBody> createState() => _CustomCommentBodyState();
}

class _CustomCommentBodyState extends State<CustomCommentBody> {
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

  @override
  Widget build(BuildContext context) {
    return Row(
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
              Commentcontent(content: widget.comment.content ?? ''),
              Row(
                children: [
                  Text(
                    "${ProfileHelper.getTimeAgoShort(DateTime.parse(widget.comment.createdAt ?? DateTime.now().toString()))}  ",
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
                    visible:
                        ((widget.comment.replies?.length != 0) && !showMore),
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
                                    borderRadius: BorderRadius.circular(100),
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.comment.replies?.length ?? 0,
                  itemBuilder: (context, commentsIndex) {
                    Comment? reply = widget.comment.replies?[commentsIndex];
                    return Replaycomment(
                      comment: widget
                          .comment, // استخدام الـ reply بدلاً من widget.comment
                      reply: reply!,
                    );
                  },
                ),
              ),
              Visibility(
                visible: ((widget.comment.replies?.length != 0) && showMore),
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
    );
  }
}
