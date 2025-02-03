import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_event.dart';
import 'package:trend/features/posts/bloc/Bloc_post/post_state.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/posts/domain/repositories/post_repository.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';
import 'package:trend/features/profile/presentation/user_profile/widgets/display_User_Posts.dart';

import '../../../../shared/const/app_links.dart';
import '../../../../shared/core/local/SharedPreferencesDemo.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  late currentUser user;
  getUserData() async {
    user = await SharedPreferencesDemo.loadUserData();
  }

  final dio = Dio();


  List<PostModel> allPosts = [];
  int id = 0;
  PostBloc(this.repository) : super(PostInitial()) {
    getUserData();
    // _getUserinformation(id);
    on<FetchPosts>(_onFetchPosts);
    on<AddPostEvent>(_onAddPost); // Add a handler for AddPostEvent
    on<AddComment>(_onAddCommentToPost); // Add a handler for AddPostEvent
    on<LikePost>(_onLikePost); // Add a handler for AddPostEvent
    on<LikeComment>(_onLikeOnComment); // Add a handler for AddPostEvent
    on<AddBlocUserEvent>(_onBlockUser); // Add a handler for AddPostEvent
    on<AddDeletePostEvent>(_deletePost); // Add a handler for AddPostEvent
    on<AddCommentOnComment>(
        _onCommentOnCommentToPost); // Add a handler for AddPostEvent
    on<getPostForSpecificUser>(_getPostForSpecificUser);
    on<LikeCommentoncomment>(_LikeCommentoncomment);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    // emit(PostLoading());

    // final posts = await repository.fetchPosts();
    // posts.fold((l) {
    //   emit(PostError(l.message));
    // }, (r) {
    //   allPosts.addAll(r);
    //   emit(PostLoaded(allPosts));
    // });
    emit(PostLoading());
    isloading = true;
    try {
      String url = ApiEndpoints.Nextpage ?? "";
      if (url.length == 0) {
        allPosts.clear();
        url = 'http://167.71.92.176/posts/all-posts/';
      }

      String? tok = await token.getToken();
      print(url);
      final response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $tok'}),
      );
      isloading = false;
      if (response.statusCode == 200) {
        ApiEndpoints.setnext(response.data["next"] ?? "");
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;

        allPosts
            .addAll(results.map((json) => PostModel.fromJson(json)).toList());

        emit(PostLoaded(allPosts));
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    } finally {}
  }

  Future<void> _onAddCommentToPost(
      AddComment event, Emitter<PostState> emit) async {
    Comment comment = Comment(
        author: user.username,
        authorId: user.id,
        content: event.content,
        post: event.postId,
        replies: []);
    List<PostModel> posts = (state as PostLoaded).posts;
    int index = posts.indexWhere((x) => x.id == event.postId);

    posts[index].comments?.add(comment);
    emit(PostLoaded(posts));
    final result = await repository.commentPost(event.postId, event.content);

    result.fold((l) {
      emit(PostError(l.message));
    }, (r) {
      posts[index].commentsCount = (posts[index].commentsCount ?? 0) + 1;
      emit(PostLoaded(posts));

      posts[index].comments?.last = r!;
      emit(PostLoaded(posts));
    });
  }

  Future<void> _onLikePost(LikePost event, Emitter<PostState> emit) async {
    List<PostModel> posts = (state as PostLoaded).posts;
    // emit(PostLoading());
    int index = posts.indexWhere((x) => x.id == event.postId);

    final result = await repository.likePost(event.postId);

    result.fold((l) {
      posts[index].likesCount = (posts[index].likesCount ?? 0) - 1;
      posts[index].isLiked = false;
      emit(PostLoaded(posts));
    }, (r) {
      if (posts[index].isLiked ?? false) {
        posts[index].likesCount = (posts[index].likesCount ?? 0) - 1;
        posts[index].isLiked = false;
      } else {
        posts[index].likesCount = (posts[index].likesCount ?? 0) + 1;
        posts[index].isLiked = true;
      }
      emit(PostLoaded(posts));
    });
  }

  Future<void> _onLikeOnComment(
      LikeComment event, Emitter<PostState> emit) async {
    List<PostModel> posts = (state as PostLoaded).posts;
    // post index
    int index = posts.indexWhere((x) => x.id == event.postId);
    PostModel postModel = posts[index];
    List<Comment> comments = postModel.comments ?? [];
    // comment inside post index
    int commentIndex = comments.indexWhere((x) => x.id == event.commentId);
    Comment comment = comments[commentIndex];

    // reply on comment index
    int? replyIndex;
    if (event.subCommentId != null) {
      List<Comment> replies = comment.replies ?? [];
      replyIndex = replies.indexWhere((x) => x.id == event.subCommentId);
    }

    if ((state as PostLoaded).isLikeLoading) {
      return;
    }
    emit(PostLoaded(posts, isLikeLoading: true));
    final result = await repository.likeComment(
        event.subCommentId == null ? event.commentId : event.subCommentId!);
    result.fold((l) {
      comments[commentIndex].likesCount =
          (comments[commentIndex].likesCount ?? 0) - 1;
      comments[commentIndex].isLiked = false;
      postModel.comments = comments;
      posts[index] = postModel;
      emit(PostLoaded(posts));
    }, (r) {
      if (replyIndex != null) {
        if (posts[index].comments?[commentIndex].replies?[replyIndex].isLiked ??
            false) {
          posts[index].comments?[commentIndex].replies?[replyIndex].isLiked =
              false;
          posts[index].comments?[commentIndex].replies?[replyIndex].likesCount =
              (posts[index]
                          .comments?[commentIndex]
                          .replies?[replyIndex]
                          .likesCount ??
                      0) -
                  1;
        } else {
          posts[index].comments?[commentIndex].replies?[replyIndex].isLiked =
              true;
          posts[index].comments?[commentIndex].replies?[replyIndex].likesCount =
              (posts[index]
                          .comments?[commentIndex]
                          .replies?[replyIndex]
                          .likesCount ??
                      0) +
                  1;
        }
      } else {
        if (posts[index].comments?[commentIndex].isLiked ?? false) {
          posts[index].comments?[commentIndex].isLiked = false;
          posts[index].comments?[commentIndex].likesCount =
              (posts[index].comments?[commentIndex].likesCount ?? 0) - 1;
        } else {
          posts[index].comments?[commentIndex].isLiked = true;
          posts[index].comments?[commentIndex].likesCount =
              (posts[index].comments?[commentIndex].likesCount ?? 0) + 1;
        }
      }
      emit(PostLoaded(posts));
    });
  }

  Future<void> _onCommentOnCommentToPost(
      AddCommentOnComment event, Emitter<PostState> emit) async {
    // Comment comment = Comment(
    //     author: user.username,
    //     authorId: user.id,
    //     content: event.content,
    //     post: event.postId,
    //     likesCount: 0,
    //     isLiked: false,
    //     replies: []);
    List<PostModel> posts = (state as PostLoaded).posts;
    int index = posts.indexWhere((x) => x.id == event.postId);
    PostModel postModel = posts[index];
    List<Comment> comments = postModel.comments ?? [];
    int commentIndex = comments.indexWhere((x) => x.id == event.commentId);
    // comments[commentIndex].replies?.add(comment);
    // postModel.comments = comments;
    // posts[index] = postModel;
    emit(PostLoaded(posts, createCommentLoading: true));
    final result = await repository.commentComment(
        postId: event.postId,
        comment: event.content,
        commentId: event.commentId);
    result.fold((l) {
      // comments[commentIndex].replies?.removeLast();
      // postModel.comments = comments;
      // posts[index] = postModel;
      // emit(PostLoaded(posts));
    }, (r) {
      posts[index].commentsCount = (posts[index].commentsCount ?? 0) + 1;
      emit(PostLoaded(posts));
      posts[index].comments?[commentIndex].replies?.add(r!);
      emit(PostLoaded(posts));
    });
  }

  // Handle AddPostEvent
  void _onAddPost(AddPostEvent event, Emitter<PostState> emit) {
    if (state is PostLoaded) {
      final currentPosts = (state as PostLoaded).posts;
      final updatedPosts = List<PostModel>.from(currentPosts)
        ..insert(0, event.post);
      emit(PostLoaded(updatedPosts));
    }
  }

  void _onBlockUser(AddBlocUserEvent event, Emitter<PostState> emit) async {
    List<PostModel> oldPosts = (state as PostLoaded).posts;
    List<PostModel> posts = (state as PostLoaded).posts;
    posts.removeWhere((e) => e.authorId == event.userId);
    emit(PostLoaded(posts));
    final result = await repository.blockUser(event.userId);
    result.fold((f) {
      emit(PostLoaded(oldPosts));
    }, (r) {});
  }

  void _deletePost(AddDeletePostEvent event, Emitter<PostState> emit) async {
    List<PostModel> oldPosts = (state as PostLoaded).posts;
    List<PostModel> posts = (state as PostLoaded).posts;
    posts.removeWhere((e) => e.id == event.postId);
    emit(PostLoaded(posts));
    final result = await repository.deletePost(event.postId);
    result.fold((f) {
      emit(PostLoaded(oldPosts));
    }, (r) {});
  }

  Future<void> _getPostForSpecificUser(
      getPostForSpecificUser event, Emitter<PostState> state) async {
    try {
      emit(getPostForSpecificUserLoading());
      List<PostModel> posts = await repository.getPostForspecificUser(event.id);
      emit(getPostForSpecificUserSuccess(posts: posts));
    } catch (e) {
      emit(getPostForSpecificUserFailuer());
    }
  }

  GotoDisplayPost(BuildContext context, List<PostModel> posts, int x) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DisplayUserPosts(x: x)));
    emit(PostLoaded(posts));
  }

  Future<void> _LikeCommentoncomment(
      LikeCommentoncomment event, Emitter<PostState> state) async {
    final result = await repository.likeComment(event.subCommentId);
  }
}
