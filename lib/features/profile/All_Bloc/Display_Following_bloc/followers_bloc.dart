// Bloc Class
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/All_Bloc/Display_Following_bloc/followers_event.dart';
import 'package:trend/features/profile/All_Bloc/Display_Following_bloc/followers_state.dart';
import 'package:trend/features/profile/data/models/FolloersModel.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

class DisplayFollowingBloc
    extends Bloc<DisplayFollowingEvent, DisplayFollowingsState> {
  final ProfileRepository profileRepository;
  List<FollowerModel> ListFollower = [];
  List<FollowerModel> ListFollowing = [];
  DisplayFollowingBloc(this.profileRepository) : super(FollowingsInitial()) {
    on<LoadFollowing1>((event, emit) async {
      emit(FollowingLoading());
      try {
        final following = await profileRepository.fetchFollowing(id: event.id);
        ListFollowing.clear();
        ListFollowing.addAll(following);
        print(ListFollowing);
        emit(FollowingLoaded(following));
      } catch (e) {
        print("ListFollowing");
        print(ListFollowing);
        emit(FollowingError(e.toString()));
      }
    });
  }
}
