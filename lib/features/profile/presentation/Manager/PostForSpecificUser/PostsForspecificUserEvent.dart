abstract class PostEvent {}

class GetUserPostsEvent extends PostEvent {
  final String userId;

  GetUserPostsEvent({required this.userId});
}
