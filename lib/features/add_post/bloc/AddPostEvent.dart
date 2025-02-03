import 'package:trend/features/add_post/domain/entities/post.dart';

sealed class AddPostEvent1 {}

class AddNewPostEvent extends AddPostEvent1 {
  final NewPost newPost;
  AddNewPostEvent(this.newPost);
}
