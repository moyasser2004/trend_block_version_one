import 'package:meta/meta.dart';

@immutable
sealed class AuthenticationEvent {}

// Login event
class AuthenticationLoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  AuthenticationLoginEvent({required this.username, required this.password});
}

class AuthenticationLogoutEvent extends AuthenticationEvent {}

class AuthenticationCheckStatusEvent extends AuthenticationEvent {}

// Register event
class AuthenticationRegisterEvent extends AuthenticationEvent {
  final String username;
  final String email;
  final String password;
  final String passwordConfirm;

  AuthenticationRegisterEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });
}

// Reset password event
class ResetPasswordEvent extends AuthenticationEvent {
  final String email;

  ResetPasswordEvent({required this.email});
}
