import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_state.dart';
import 'package:trend/features/posts/presentation/Pages/main_post.dart';

class DisplayMyPosts extends StatefulWidget {
  const DisplayMyPosts({super.key, required this.x});
  // final List<PostModel> posts;
  final int x;

  @override
  State<DisplayMyPosts> createState() => _DisplayUserPostsState();
}

class _DisplayUserPostsState extends State<DisplayMyPosts> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
        widget.x *
            200.0, // Replace 100.0 with the approximate height of each item
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
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            floating: false,
            pinned: true,
            expandedHeight: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "My Posts",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),
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
                return Text("Erroe");
              }
            },
          ),
        ],
      ),
    );
  }
}
