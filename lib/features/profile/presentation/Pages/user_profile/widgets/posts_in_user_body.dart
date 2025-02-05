import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_state.dart';
import 'package:trend/shared/const/colors.dart';

class PostsInUserBody extends StatefulWidget {
  const PostsInUserBody({super.key, required this.userid});
  final int userid;
  @override
  State<PostsInUserBody> createState() => _PostsInUserBodyState();
}

class _PostsInUserBodyState extends State<PostsInUserBody> {
  @override
  void initState() {
    super.initState();
    // إضافة الحدث في initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProfileBloc>(context)
          .add(getPostForUserevent(id: widget.userid));
    });
  }

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
                        image: NetworkImage(state.posts[index].image ??
                            "http://167.71.92.176/media/posts/images/image_cropper_1738583991667.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is getPostForspecificUserLoading) {
            return GridView.builder(
                itemCount: 9,
                padding: EdgeInsets.only(top: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of items per row
                  crossAxisSpacing: 1.0, // Space between columns
                  mainAxisSpacing: 1.0, // Space between rows
                ),
                shrinkWrap: true, // Prevents GridView from expanding infinitely
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Skeletonizer.zone(
                        effect: ShimmerEffect(
                          duration: const Duration(milliseconds: 1500),
                          baseColor: Color(AppColors.greyLight),
                          highlightColor: Color(AppColors.white),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          elevation: 0,
                          color: Color(AppColors.white),
                          child: ListTile(
                            leading: Bone.circle(size: 60),
                            title: Bone.text(words: 2),
                            subtitle: Bone.text(),
                          ),
                        ),
                      ),
                    ));
          } else {
            return Center(
              child: Text("No Post"),
            );
          }
        });
  }
}
