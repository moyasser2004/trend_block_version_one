import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/add_post/bloc/AddPostEvent.dart';
import 'package:trend/features/add_post/bloc/Add_Post_State.dart';
import 'package:trend/features/add_post/domain/repositories/AddNewPost_Function.dart';

class AddPostBloc extends Bloc<AddPostEvent1, AddPostState> {
  final Addnewpostrepo addnewpostrepo;

  AddPostBloc(this.addnewpostrepo) : super(AddPostInitial()) {
    on<AddNewPostEvent>(_onAddNewPost);
  }

  Future<void> _onAddNewPost(
      AddNewPostEvent event, Emitter<AddPostState> emit) async {
    emit(AddPostLoading());
    try {
      await addnewpostrepo.uploadPost(post: event.newPost);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int c = await int.parse(sharedPreferences.getString('totalPosts')!);

      c++;
      bool x = await sharedPreferences.setString('totalPosts', c.toString());

      emit(AddPostSuccess());
    } catch (error) {
      emit(AddPostFailure(error.toString()));
    }
  }
}
