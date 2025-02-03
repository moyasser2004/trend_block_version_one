sealed class AddPostState {}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {}

class AddPostFailure extends AddPostState {
  final String errorMessage;
  AddPostFailure(this.errorMessage);
}
