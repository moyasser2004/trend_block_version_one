import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/authentication/domain/entities/user.dart';
import 'package:trend/features/authentication/domain/repositories/auth_repository.dart';

import '../../../shared/const/app_links.dart';
import '../../../shared/core/local/SharedPreferencesDemo.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final dio = Dio(BaseOptions(
    followRedirects: true, // Automatically follow redirects
    validateStatus: (status) {
      return status! < 500; // Allow all status codes below 500
    },
  ));
  final AuthenticationApi authApi;
  SharedPreferencesDemo sharedPreferencesDemo = SharedPreferencesDemo();
  AuthenticationBloc({required this.authApi}) : super(AuthenticationInitial()) {
    // Handle login event
    on<AuthenticationLoginEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final response = await dio.post(
          ApiEndpoints.login,
          data: {'username': event.username, 'password': event.password},
        );
        await token.setToken(response.data["access"]);
        final data = response.data['user_info'];
        User user = User(
            id: data['id']?.toString() ??
                "", // إذا كان id null، يتم تعيين سلسلة فارغة
            username: data['username'] ??
                "", // إذا كان username null، يتم تعيين سلسلة فارغة
            email: data['email'] ??
                "", // إذا كان email null، يتم تعيين سلسلة فارغة
            fullName: data['full_name'], // يمكن أن تكون null
            avatar: data['avatar'], // يمكن أن تكون null
            bio: data['bio'] ??
                'Hardcoded Bio for Debugging', // إضافة قيمة افتراضية
            mobile: data['mobile'], // يمكن أن تكون null
            followers: data['followers'] ?? 0, // إذا كان null، يتم تعيين 0
            following: data['following'] ?? 0, // إذا كان null، يتم تعيين 0
            totalPosts: data['total_posts'] ?? 0, // إذا كان null، يتم تعيين 0
            totalLikes: data['total_likes'] ?? 0, // إذا كان null، يتم تعيين 0
            is_private: data['is_private'] ?? false);

        await sharedPreferencesDemo.saveUserData(
            id: user.id,
            email: user.email,
            username: user.username,
            fullName: user.fullName ?? "null",
            avatar: user.avatar ?? "null",
            bio: user.bio ?? 'Null',
            mobile: user.mobile ?? "null",
            followers: user.followers.toString(),
            following: user.following.toString(),
            totalPosts: user.totalPosts.toString(),
            totalLikes: user.totalLikes.toString(),
            is_private: user.is_private);

        emit(AuthenticationAuthenticated(username: user.username));
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });

    // Handle logout event
    on<AuthenticationLogoutEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        // Simulate logout
        await Future.delayed(const Duration(seconds: 1));
        emit(AuthenticationUnauthenticated());
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });

    on<AuthenticationCheckStatusEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        // Simulate dynamic authentication status
        final isAuthenticated =
            DateTime.now().second % 2 == 0; // Simulates true/false dynamically

        if (isAuthenticated) {
          emit(AuthenticationAuthenticated(username: "ExistingUser"));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });

    // Handle registration event
    on<AuthenticationRegisterEvent>((event, emit) async {
      emit(RegistrationLoading());
      try {
        final user = await authApi.register(
          username: event.username,
          email: event.email,
          password: event.password,
          passwordConfirm: event.passwordConfirm,
        );

        await sharedPreferencesDemo.saveUserData(
          is_private: user.is_private ?? false,
          id: user.id ?? "0",
          email: user.email ?? "null",
          username: user.username ?? "null",
          fullName: user.fullName ?? "null",
          avatar: user.avatar ?? "null",
          bio: user.bio ?? "Null",
          mobile: user.mobile ?? "null",
          followers: user.followers.toString() ?? "0",
          following: user.following.toString() ?? "0",
          totalPosts: user.totalPosts.toString() ?? "0", // Added totalPosts
          totalLikes: user.totalLikes.toString() ?? "0", // Added totalLikes
        );

        emit(RegistrationSuccess(message: user.username));
      } catch (e) {
        emit(RegistrationError(message: e.toString()));
      }
    });

    // Handle reset password event
    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthenticationLoading()); // Emit loading state
      try {
        final message = await authApi.resetPassword(event.email);
        emit(ResetPasswordSuccess(message: message)); // Emit success state
      } catch (e) {
        emit(AuthenticationError(message: e.toString())); // Emit error state
      }
    });
  }
}
