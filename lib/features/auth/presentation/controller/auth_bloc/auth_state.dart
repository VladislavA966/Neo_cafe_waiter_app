part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  final String email;

  AuthLoaded({required this.email});
}

final class AuthError extends AuthState {
  final String errorText;

  AuthError({required this.errorText});
}

final class LoginValidationError extends AuthState {
  final String errorText;

  LoginValidationError({required this.errorText});
}

final class PasswordValidationError extends AuthState {
  final String errorText;

  PasswordValidationError({required this.errorText});
}

final class CodeLoaded extends AuthState {}
