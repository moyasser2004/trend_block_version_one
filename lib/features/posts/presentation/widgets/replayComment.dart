import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/features/posts/data/models/CommentModel.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_event.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';

// ignore: must_be_immutable
class Replaycomment extends StatefulWidget {
  const Replaycomment({super.key, required this.reply, required this.comment});
  final Comment reply;
  final Comment comment;
  @override
  State<Replaycomment> createState() => _ReplaycommentState();
}

class _ReplaycommentState extends State<Replaycomment> {
  void initState() {
    super.initState();
    _loadUserReplayAvatar();
  }

  String replayavatar =
      "http://167.71.92.176/media/profile_images/default_image.jpg";
  Future<void> _loadUserReplayAvatar() async {
    String Newavatar1 = await BlocProvider.of<PostBloc>(context)
        .repository
        .getUserAvatar(widget.reply.authorId!);
    print(replayavatar);
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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Networkimages(
          imageUrl: replayavatar,
          size: 20,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.reply.author ?? '',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1F2232)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: getMentionedNamae(widget.reply.content ?? ''),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color: Colors.blue),
                      ),
                      TextSpan(
                        text: getWithoutMentionedNamae(
                            widget.reply.content ?? ''),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color: Color(0xff9E9E9E)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<PostBloc>().add(LikeComment(
                commentId: widget.comment.id!,
                postId: widget.comment.post!,
                subCommentId: widget.reply.id));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              (widget.reply.isLiked ?? false)
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
              Text(
                "${widget.reply.likesCount == 0 ? '' : widget.reply.likesCount}",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
