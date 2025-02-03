import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_event.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_BlockAndunBlock/blockandunblock.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_BlockAndunBlock/blockandunblockState.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_BlockAndunBlock/blockandunblockevent.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';

class Bloclist extends StatelessWidget {
  const Bloclist({super.key, required this.posts, required this.id});
  final List<ProfileModel> posts;
  final int id;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20, // Adjust the size
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.network(
                    posts[index].avatar,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              title: Text(
                posts[index].user,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  BlocProvider.of<Blockbloc>(context)
                      .add(unBlock(id: posts[index].id));
                },
                child: BlocConsumer<Blockbloc, Blockandunblockstate>(
                  listener: (context, state) {
                    if (state is unBlocFailuer || state is unBlocsuccess) {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(getBlockedUser(id: id));
                    }
                    if (state is unBlocsuccess) {
                      BlocProvider.of<PostBloc>(context).add(FetchPosts());
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      height: 25.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 23, 173, 46),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Unblock',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (index < posts.length - 1)
              Padding(
                padding: EdgeInsets.only(left: 65.w, right: 23.w),
                child: Divider(
                  color: Colors.grey[300],
                ),
              ),
          ],
        );
      },
    );
  }
}
