import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/notifications/bloc/FollowBack/FollowBackState.dart';
import 'package:trend/features/notifications/bloc/FollowBack/FollowBackevent.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

class FollowingbackBloc extends Bloc<FollowingbackEvent, FollowingbackState> {
  Dio dio;
  final ProfileRepository repository;
  FollowingbackBloc(this.dio, this.repository)
      : super(FollowingBackInitialState()) {
    on<FollowbackUserEvent>(_followUserEvent);
    // on<UnFollowbackUserEvent>(_unfollowUserEvent);
  }

  Future<void> _followUserEvent(
      FollowbackUserEvent event, Emitter<FollowingbackState> emit) async {
    emit(FollowingBackLoadding(index: event.index));
    try {
      await repository.followUser(event.userId);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int c = await int.parse(sharedPreferences.getString('following')!);

      c++;
      bool x = await sharedPreferences.setString('following', c.toString());
      print("follow success $x");
      print(c);
      emit(FollowingBackSuccess(index: event.index));
    } catch (e) {
      emit(FollowingBackFailuer());
    }
  }

  // Future<void> _unfollowUserEvent(
  //     UnFollowUserEvent event, Emitter<FollowingState> emit) async {
  //   emit(UnFollowingLoadding());
  //   try {
  //     await repository.unfollowUser(event.userId);
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();

  //     int c = await int.parse(sharedPreferences.getString('following')!);
  //     c--;
  //     bool x = await sharedPreferences.setString('following', c.toString());
  //     print("unfollow success $x");
  //     print(c);
  //     emit(UnFollowingSuccess());
  //   } catch (e) {
  //     emit(UnFollowingFailuer());
  //     ;
  //   }
  // }
}
