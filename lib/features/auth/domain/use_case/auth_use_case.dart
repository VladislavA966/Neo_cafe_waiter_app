import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/auth/domain/entity/waiter_email_entity.dart';
import 'package:neo_cafe_24/features/auth/domain/repo/auth_repo.dart';

class AuthUseCase extends UseCase<WaiterEmailEntity, AuthParams> {
  final AuthRepo repo;

  AuthUseCase({required this.repo});
  @override
  Future<WaiterEmailEntity> call(AuthParams params) async {
    return await repo.authRepo(params.login, params.password);
  }
}

class AuthParams {
  final String login;
  final String password;

  AuthParams({required this.login, required this.password});
}
