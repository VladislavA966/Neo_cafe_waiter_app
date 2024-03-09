part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class GetAuthEvent extends AuthEvent {
  final String login;
  final String password;

  GetAuthEvent({required this.login, required this.password});
}

class SendCodeEvent extends AuthEvent {
  final String code;

  SendCodeEvent({required this.code});
}
