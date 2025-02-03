import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/features/posts/data/models/CommentModel.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_event.dart';
import 'package:trend/features/posts/presentation/widgets/custom_comment_body.dart';

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

  // Future<void> _loadUserReplayAvatar(int id) async {
  //   String Newavatar1 =
  //       await BlocProvider.of<PostBloc>(context).repository.getUserAvatar(id);

  //   setState(() {
  //     replayavatar = Newavatar1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String c = widget.comment.likesCount.toString() ?? 0.toString();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Stack(
        children: [
          CustomCommentBody(
            comment: widget.comment,
            replyFunction: widget.replyFunction,
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
