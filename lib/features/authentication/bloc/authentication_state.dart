import 'package:flutter/material.dart';

@immutable
sealed class AuthenticationState {}

// Initial state when the app starts
class AuthenticationInitial extends AuthenticationState {}

// State while performing an authentication action (e.g., logging in)
class AuthenticationLoading extends AuthenticationState {}

// State when the user is successfully authenticated
class AuthenticationAuthenticated extends AuthenticationState {
  final String username;

  AuthenticationAuthenticated({required this.username});
}

// State when the user is logged out or unauthenticated
class AuthenticationUnauthenticated extends AuthenticationState {}

// State for authentication-related errors
class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError({required this.message});
}

// Add states for the registration flow
class RegistrationLoading extends AuthenticationState {}

class RegistrationSuccess extends AuthenticationState {
  final String message;

  RegistrationSuccess({required this.message});
}

class RegistrationError extends AuthenticationState {
  final String message;

  RegistrationError({required this.message});
}

// Add states for the password reset flow
class ResetPasswordSuccess extends AuthenticationState {
  final String message;

  ResetPasswordSuccess({required this.message});
}
