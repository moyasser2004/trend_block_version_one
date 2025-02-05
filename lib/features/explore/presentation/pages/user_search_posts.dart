import 'package:flutter/material.dart';
import 'package:trend/features/explore/domain/entities/for_you_search.dart';
import 'package:trend/features/posts/presentation/Pages/main_post.dart';

import '../../../../shared/const/colors.dart';
import '../../../../shared/style/app_styles.dart';
import '../../../posts/data/models/post_model.dart';

class UserSearchPostsPage extends StatefulWidget {
  const UserSearchPostsPage(
      {Key? key, required this.posts, required this.search})
      : super(key: key);

  final List<RecentPost>? posts;
  final String search;

  @override
  State<UserSearchPostsPage> createState() => _UserSearchPostsPageState();
}

class _UserSearchPostsPageState extends State<UserSearchPostsPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.posts == null || widget.posts!.isEmpty) {
      return Scaffold(body: Center(child: Text('No posts found')));
    }
    return Scaffold(
        backgroundColor: Color(AppColors.white),
        appBar: UserSearchPostAppBar(title: widget.search),
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: widget.posts!.length + 1,
              itemBuilder: (context, index) {
                if (index == widget.posts?.length) {
                  return Center(child: SizedBox());
                }
                return MainPost(
                  post: PostModel.fromJson({
                    "id": widget.posts![index].id,
                    "author": widget.posts![index].author,
                    "author_id": widget.posts![index].authorId,
                    "avatar": widget.posts![index].avatar,
                    "description": widget.posts![index].description,
                    "image": widget.posts![index].image,
                    "is_liked": widget.posts![index].isLiked,
                    "created_at": widget.posts![index].createdAt.toString(),
                    "updated_at": widget.posts![index].updatedAt.toString(),
                    "likes_count": widget.posts![index].likesCount,
                    "comments_count": widget.posts![index].commentsCount,
                    "shares_count": widget.posts![index].sharesCount,
                    "views_count": widget.posts![index].viewsCount,
                    "is_public": widget.posts![index].isPublic,
                    "allow_comments": widget.posts![index].allowComments,
                    "comments": widget.posts![index].comments ?? [],
                  }),
                  index: index,
                );
              },
            ),
          ],
        ));
  }
}

class UserSearchPostAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const UserSearchPostAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title:
          Text(title, style: AppStyles.styleSemiBold21.copyWith(fontSize: 18)),
      shadowColor: Color(AppColors.black),
      elevation: 0,
      surfaceTintColor: Color(AppColors.white),
      backgroundColor: Color(AppColors.white),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
