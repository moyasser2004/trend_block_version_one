import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_Bloc.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_event.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_event.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';
import 'package:trend/features/posts/presentation/widgets/comment_widget.dart';
import 'package:trend/features/posts/presentation/widgets/customTextFiled.dart';

import '../../../../shared/core/local/SharedPreferencesDemo.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({super.key, required this.post, required this.postindex});
  final PostModel post;
  final int postindex;
  @override
  _CommentSheetState createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  String avatar = "/media/profile_images/default_image.jpg";
  void initState() {
    super.initState();
    _loadAvatar();
  }

  void _loadAvatar() async {
    final loadedAvatar = await SharedPreferencesDemo.getAvatar();
    setState(() {
      avatar = loadedAvatar;
    });
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
  void dispose() {
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  bool isReply = false;
  int commentId = 0;
  FocusNode focusNode = FocusNode();
  replyFunction(Comment comment) {
    isReply = true;
    commentId = comment.id ?? 0;
    _controller.text = "@" + (comment.author ?? '') + ' ';
    focusNode.requestFocus();
  }

  bool isMe = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50.sp,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 3,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xffE7ECF0)),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Comments "),
                  Text("${widget.post.commentsCount}")
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Color(0xffE7ECF0),
                thickness: 0.2,
                height: 1,
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (widget.post.comments != null)
                      ListView(
                        reverse: true,
                        shrinkWrap:
                            true, // يسمح بـ ListView أن يكون بحجم التعليقات فقط
                        physics:
                            NeverScrollableScrollPhysics(), // لمنع التمرير داخل ListView الداخلية
                        children: widget.post.comments!.map((comment) {
                          return CommentWidget(comment, replyFunction);
                        }).toList(),
                      ),
                    SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom > 0
                            ? MediaQuery.of(context).size.height * 0.5
                            : 100),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom + 5
                : 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16.w,
                    right: 1.w,
                    top: 8.h,
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 8.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<BottomNavBloc>(context)
                            .add(BottomNavItemSelected(4));
                      },
                      child: Networkimages(
                        imageUrl: 'http://167.71.92.176$avatar',
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextFiledForComment(
                        controller: _controller,
                        onChanged: (String) {
                          setState(() {});
                        },
                        onTap: () {
                          if (_controller.text.isNotEmpty) {
                            if (isReply) {
                              context.read<PostBloc>().add(AddCommentOnComment(
                                  postId: widget.post.id ?? 0,
                                  commentId: commentId,
                                  content: _controller.text));
                            } else {
                              context.read<PostBloc>().add(AddComment(
                                  postId: widget.post.id!,
                                  content: _controller.text));
                            }
                            _controller.text = "";
                            commentId = 0;
                            isReply = false;
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please Enter Any Text",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
/**
 * 
 * 
 * 
                    // SizedBox(height: 6.h),
                    // HeaderPost(post: widget.post),
                    // BodyPost(post: widget.post),
                    // ActivitiesPost(
                    //   post: widget.post,
                    //   postIndex: widget.postindex,
                    // ),
                    // Divider(color: Colors.grey, thickness: 0.1.h),

                    // هنا نضع ListView خاص للتعليقات
 * TextFormField(
                        focusNode: focusNode,
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: "Add Comment...",
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[400],
                          ),
                          fillColor: Color(0xffF9F9FC),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 16.w,
                          ),
                          suffixIcon: SizedBox(
                            height: 15,
                            child: GestureDetector(
                                onTap: () {
                                  if (_controller.text.isNotEmpty) {
                                    if (isReply) {
                                      context.read<PostBloc>().add(
                                          AddCommentOnComment(
                                              postId: widget.post.id ?? 0,
                                              commentId: commentId,
                                              content: _controller.text));
                                    } else {
                                      context.read<PostBloc>().add(AddComment(
                                          postId: widget.post.id!,
                                          content: _controller.text));
                                    }
                                    _controller.text = "";
                                    commentId = 0;
                                    isReply = false;
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please Enter Any Text",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/button.svg", // تأكد من أن الملف بصيغة SVG
                                  fit: BoxFit.none,
                                  height: 36,
                                  width: 36,
                                )),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      )
 */
