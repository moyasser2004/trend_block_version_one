import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/State_Following.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_Following/event_Following.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  Dio dio;
  final ProfileRepository repository;
  FollowingBloc(this.dio, this.repository) : super(FollowingInitialState()) {
    on<FollowUserEvent>(_followUserEvent);
    on<UnFollowUserEvent>(_unfollowUserEvent);
  }

  Future<void> _followUserEvent(
      FollowUserEvent event, Emitter<FollowingState> emit) async {
    emit(FollowingLoadding());
    try {
      await repository.followUser(event.userId);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int c = await int.parse(sharedPreferences.getString('following')!);

      c++;
      bool x = await sharedPreferences.setString('following', c.toString());
      print("follow success $x");
      print(c);
      emit(FollowingSuccess());
    } catch (e) {
      emit(FollowingFailuer());
    }
  }

  Future<void> _unfollowUserEvent(
      UnFollowUserEvent event, Emitter<FollowingState> emit) async {
    emit(UnFollowingLoadding());
    try {
      await repository.unfollowUser(event.userId);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      int c = await int.parse(sharedPreferences.getString('following')!);
      c--;
      bool x = await sharedPreferences.setString('following', c.toString());
      print("unfollow success $x");
      print(c);
      emit(UnFollowingSuccess());
    } catch (e) {
      emit(UnFollowingFailuer());
      ;
    }
  }
}
