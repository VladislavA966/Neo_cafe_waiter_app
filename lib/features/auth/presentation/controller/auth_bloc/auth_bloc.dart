import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/core/services/validation.dart';
import 'package:neo_cafe_24/features/auth/domain/use_case/auth_use_case.dart';
import 'package:neo_cafe_24/features/auth/domain/use_case/send_code_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ValidationMixin {
  final AuthUseCase authUseCase;
  final SendCodeUseCase codeUseCase;
  AuthBloc(this.authUseCase, this.codeUseCase) : super(AuthInitial()) {
    on<GetAuthEvent>(
      _getAuthEvent,
    );
    on<SendCodeEvent>(
      _sendCodeEvent,
    );
  }

  Future<void> _sendCodeEvent(
      SendCodeEvent event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    );
    try {
      await codeUseCase.call(
        SendCodeParams(
          code: event.code,
        ),
      );
      emit(
        CodeLoaded(),
      );
    } catch (e) {
      emit(
        AuthError(
          errorText: e.toString(),
        ),
      );
    }
  }

  Future<void> _getAuthEvent(
      GetAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final email = await authUseCase.call(
        AuthParams(
          login: event.login,
          password: event.password,
        ),
      );
      emit(
        AuthLoaded(email: email.email),
      );
    } catch (e) {
      emit(
        AuthError(
          errorText: "Неверный логин или пароль",
        ),
      );
    }
  }
}
