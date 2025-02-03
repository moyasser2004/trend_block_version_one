import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_Bloc.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_event.dart';
import 'package:trend/features/posts/data/models/CommentModel.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_event.dart';
import 'package:trend/features/posts/presentation/widgets/CommentSheet_Header.dart';
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
              CommentsheetHeader(
                commentcount: "${widget.post.commentsCount}",
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
