import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_event.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_state.dart';
import 'package:trend/features/posts/presentation/widgets/comment_sheet.dart';

class ActivitiesPost extends StatefulWidget {
  ActivitiesPost({super.key, required this.postIndex, required this.post});
  final int postIndex;
  final PostModel post;
  @override
  _ActivitiesPostState createState() => _ActivitiesPostState();
}

class _ActivitiesPostState extends State<ActivitiesPost> {
  bool isLiked = false;

  void toggleLike() {
    context.read<PostBloc>().add(LikePost(postId: widget.post.id!));
  }

  void showCustomBottomSheetTOshare(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isKeyboardOpen =
                  MediaQuery.of(context).viewInsets.bottom > 0;

              return FractionallySizedBox(
                heightFactor: isKeyboardOpen ? 1.0 : 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xffE7ECF0)),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Share With',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1F2232)),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildIconWithLabel(FontAwesomeIcons.download,
                                  'Download  ', Colors.grey),
                              _buildIconWithLabel(
                                  Icons.link, 'Copy Link  ', Colors.black),
                              _buildIconWithLabel(FontAwesomeIcons.instagram,
                                  'Instagram  ', Colors.black),
                              _buildIconWithLabel(FontAwesomeIcons.whatsapp,
                                  'whatsapp  ', Colors.green),
                              _buildIconWithLabel(FontAwesomeIcons.facebook,
                                  'Facebook  ', Colors.blue),
                              _buildIconWithLabel(
                                  FontAwesomeIcons.facebookMessenger,
                                  'Messenger  ',
                                  Colors.blue),
                              _buildIconWithLabel(FontAwesomeIcons.snapchat,
                                  'Snapchat  ', Colors.yellow),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 5,
                              width: 148,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xffE7ECF0)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            size: 28,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff1F2232))),
      ],
    );
  }

  Widget _buildContactRow(String name, String imagePath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: () {},
        child: Text(
          'Send',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Like Button
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggleLike();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (widget.post.isLiked ?? false)
                          ? SvgPicture.asset(
                              "assets/icons/like_fill.svg") // Filled like icon
                          : SvgPicture.asset("assets/icons/like.svg"),
                      SizedBox(width: 3.w),
                      Text(
                        '${widget.post.likesCount == 0 ? '' : widget.post.likesCount} Like${(widget.post.likesCount ?? 0) > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // Comment Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return BlocBuilder<PostBloc, PostState>(
                            builder: (context, state) {
                              if (state is PostLoaded) {
                                final isKeyboardOpen =
                                    MediaQuery.of(context).viewInsets.bottom >
                                        0;

                                return FractionallySizedBox(
                                  heightFactor: isKeyboardOpen
                                      ? MediaQuery.of(context).size.height *
                                          0.95 /
                                          MediaQuery.of(context).size.height
                                      : widget.post.commentsCount! > 1
                                          ? (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.95) /
                                              (MediaQuery.of(context)
                                                  .size
                                                  .height)
                                          : 0.7,
                                  child: CommentSheet(
                                    postindex: widget.postIndex,
                                    post: state.posts[widget.postIndex],
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          );
                        },
                      );
                      ;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/comment.svg',
                          height: 15,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${widget.post.commentsCount == 0 ? '' : widget.post.commentsCount} Comment${(widget.post.commentsCount ?? 0) > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showCustomBottomSheetTOshare(context);
                      //Share.share("'check out my website https://example.com'");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SvgPicture.asset(
                            'assets/icons/share.svg',
                            height: 15,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.post.description != null &&
              widget.post.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ExpandableText(
                  widget.post.description!,
                  expandText: 'show more',
                  collapseText: '... show less',
                  maxLines: 3,
                  linkColor: const Color.fromARGB(255, 162, 162, 162),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ),
            ),
          SizedBox(
            height: 7.h,
          ),
        ],
      ),
    );
  }
}
