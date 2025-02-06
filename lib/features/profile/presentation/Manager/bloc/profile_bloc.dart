import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/profile/data/models/profile_model.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';
import 'package:trend/features/profile/domain/repositories/updateProfile.dart';
import 'package:trend/shared/core/shared_preferences.dart';

import '../../../../../shared/core/local/SharedPreferencesDemo.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;
  final UpdateProfileRepository updateProfileRepository;
  final dio = Dio();

  ProfileBloc(this.repository, this.updateProfileRepository)
      : super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<getPostForUserevent>(_getPostForUserMethod);
    on<getBlockedUser>(_getBlockedUser);
    on<Logout>(_Logout);
    on<Delete>(_Delete);
    on<UpdateAvatar>(_UpdateAvatar);
    on<ResetProfileState>((event, emit) {
      emit(ProfileInitial());
    });
    on<Updatebio>(_Updatebio);
    on<Updatefullname>(_Updatefullname);
    on<Accountprivacy>(_Accountprivacy);
  }

  /// Fetch user profile
  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final userProfile = await repository.getProfile(event.id);
    userProfile.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) {
        if (profile != null) {
          emit(ProfileLoaded(profile));
        } else {
          emit(ProfileError("Profile not found"));
        }
      },
    );
  }

  Future<void> _getPostForUserMethod(
    getPostForUserevent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(getPostForspecificUserLoading());
      String? tok = await token.getToken();
      final response = await dio.get(
        "http://167.71.92.176/posts/${event.id}/posts/",
        options: Options(
          headers: {'Authorization': 'Bearer $tok'},
        ),
      );

      var data = response.data["results"];
      List<PostModel> posts = [];
      for (var element in data) {
        posts.add(PostModel.fromJson(element));
      }
      // var posts = await updateProfileRepository.getPostForUserMethod(event.id);
      emit(getPostForspecificUser(posts: posts));
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}'); // Server response details
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> _getBlockedUser(
    getBlockedUser event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(getBlockedUserLoading());
      // String? tok = await token.getToken();
      // final response = await dio.get(
      //   "http://167.71.92.176/profile/blocked/",
      //   options: Options(
      //     headers: {'Authorization': 'Bearer $tok'},
      //   ),
      // );

      List<ProfileModel> posts = await updateProfileRepository.getBlockedUser();

      emit(getBlockedUserLoaded(posts: posts));
    } catch (e) {
      emit(getBlockedUserFailuer());
    }
  }

  Future<void> _Logout(
    Logout event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(LogoutLoading());

      SharedPreferencesDemo sh = SharedPreferencesDemo();
      await sh.clearUserData();
      emit(Logoutsuccess());
    } catch (e) {
      emit(LogoutFailuer());
    }
  }

  Future<void> _Delete(
    Delete event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(DeleteLoading());
      final response = await updateProfileRepository.delete();

      emit(Deletesuccess());
    } catch (e) {
      emit(DeleteFailuer());
    }
  }

  Future<void> _Updatebio(
    Updatebio event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(UpdateLoading());
      // String? tok = await token.getToken();

      // final data = {
      //   "bio": event.bio,
      // };
      // final response = await dio.put(
      //   "http://167.71.92.176/profile/${event.id}/",
      //   data: FormData.fromMap(data),
      //   options: Options(
      //     headers: {'Authorization': 'Bearer $tok'},
      //   ),
      // );
      final response =
          await updateProfileRepository.updateBio("${event.id}", event.bio!);
      if (response.statusCode == 200) {
        emit(Updatesuccess(
          response.data["avatar"],
          response.data["bio"] ?? "",
          response.data["full_name"] ?? "",
        ));
      } else {
        emit(UpdateFailuer());
      }
    } catch (e) {
      print("Error: $e");
      emit(UpdateFailuer());
    }
  }

  Future<void> _Updatefullname(
    Updatefullname event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(UpdateLoading());
      final response = await updateProfileRepository.updatefullname(
          "${event.id}", event.full_name);
      if (response.statusCode == 200) {
        emit(Updatesuccess(
          response.data["avatar"],
          response.data["bio"] ?? "",
          response.data["full_name"] ?? "",
        ));
      } else {
        emit(UpdateFailuer());
      }
    } catch (e) {
      print("Error: $e");
      emit(UpdateFailuer());
    }
  }

  Future<void> _UpdateAvatar(
    UpdateAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(UpdateLoading());
      // String? tok = await token.getToken();

      // String fileName;
      // fileName = path.basename(event.image.path);

      // final data = {
      //   "avatar":
      //       await MultipartFile.fromFile(event.image.path, filename: fileName)
      // };
      // final response = await dio.put(
      //   "http://167.71.92.176/profile/${event.id}/",
      //   data: FormData.fromMap(data),
      //   options: Options(
      //     headers: {'Authorization': 'Bearer $tok'},
      //   ),
      // );
      final response = await updateProfileRepository.updateAvatar(
          "${event.id}", event.image);

      if (response.statusCode == 200) {
        emit(Updatesuccess(
          response.data["avatar"],
          response.data["bio"] ?? "",
          response.data["full_name"] ?? "",
        ));
      } else {
        emit(UpdateFailuer());
      }
    } catch (e) {
      print("Error: $e");
      emit(UpdateFailuer());
    }
  }

  Future<void> _Accountprivacy(
    Accountprivacy event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      String? tok = await token.getToken();

      final data = {
        "is_private": event.private,
      };
      final response = await dio.put(
        "http://167.71.92.176/profile/${event.id}/",
        data: FormData.fromMap(data),
        options: Options(
          headers: {'Authorization': 'Bearer $tok'},
        ),
      );
    } catch (e) {
      print("Error: $e");
      emit(UpdateFailuer());
    }
  }
}
