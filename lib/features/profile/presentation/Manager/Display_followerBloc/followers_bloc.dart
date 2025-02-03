// Bloc Class
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/data/models/FolloersModel.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';
import 'package:trend/features/profile/presentation/Manager/Display_followerBloc/followers_event.dart';
import 'package:trend/features/profile/presentation/Manager/Display_followerBloc/followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
  final ProfileRepository profileRepository;
  List<FollowerModel> ListFollower = [];
  FollowersBloc(this.profileRepository) : super(FollowersInitial()) {
    on<LoadFollowers>((event, emit) async {
      emit(FollowersLoading());
      try {
        final followers = await profileRepository.fetchFollowers(id: event.id);

        emit(FollowersLoaded(followers));
      } catch (e) {
        emit(FollowersError(e.toString()));
      }
    });
  }
}
