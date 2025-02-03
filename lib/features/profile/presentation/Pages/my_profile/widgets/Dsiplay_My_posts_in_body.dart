import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_Current_user/Current%20_user_Bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_Current_user/Current%20_user_state.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';

class DsiplayMyPostsInBody extends StatelessWidget {
  const DsiplayMyPostsInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserBloc, CurrentuserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GetPostForCurrentUserSuccess) {
          return Wrap(
            spacing: 1.0, // Horizontal space between items
            runSpacing: 1.0, // Vertical space between rows
            children: List.generate(
              state.posts.length, // Number of photos
              (index) => GestureDetector(
                onTap: () {
                  BlocProvider.of<PostBloc>(context)
                      .GotoDisplayPost(context, state.posts, index);
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 5) / 3,
                  height: (MediaQuery.of(context).size.width - 5) /
                      3, // Keep height the same for square shape
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.posts[index].image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is GetPostForCurrentUserLoading) {
          return CircularProgressIndicator(
            color: Colors.black,
          );
        } else {
          return Text("NOt found post");
        }
      },
    );
  }
}
