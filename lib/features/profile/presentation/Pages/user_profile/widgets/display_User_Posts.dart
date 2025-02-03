import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_state.dart';
import 'package:trend/features/posts/presentation/Pages/main_post.dart';

class DisplayUserPosts extends StatefulWidget {
  const DisplayUserPosts({super.key, required this.x});
  final int x;

  @override
  State<DisplayUserPosts> createState() => _DisplayUserPostsState();
}

class _DisplayUserPostsState extends State<DisplayUserPosts> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
        widget.x *
            200.0, // Replace 200.0 with the approximate height of each item
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          "Posts",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.black, // Text color
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            BlocConsumer<PostBloc, PostState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is PostLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => MainPost(
                        post: state.posts[index],
                        index: index,
                      ),
                      childCount: state.posts.length,
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "Error",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
