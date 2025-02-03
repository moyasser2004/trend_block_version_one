import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_bloc.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_bloc.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_state.dart';

class PostsInUserBody extends StatelessWidget {
  const PostsInUserBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is getPostForspecificUser) {
            return GridView.builder(
              padding: EdgeInsets.only(top: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of items per row
                crossAxisSpacing: 1.0, // Space between columns
                mainAxisSpacing: 1.0, // Space between rows
              ),
              shrinkWrap: true, // Prevents GridView from expanding infinitely
              physics:
                  const NeverScrollableScrollPhysics(), // Disable inner scrolling
              itemCount: state.posts.length, // Number of items in the grid
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<PostBloc>(context)
                        .GotoDisplayPost(context, state.posts, index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(state.posts[index].image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No Post"),
            );
          }
        });
  }
}
