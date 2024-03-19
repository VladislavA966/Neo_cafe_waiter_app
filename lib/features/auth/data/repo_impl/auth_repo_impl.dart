import 'package:neo_cafe_24/features/auth/data/data_source/remote_data_source/auth_remote_data.dart';
import 'package:neo_cafe_24/features/auth/domain/entity/waiter_email_entity.dart';
import 'package:neo_cafe_24/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemote remote;

  AuthRepoImpl({required this.remote});
  @override
  Future<WaiterEmailEntity> authRepo(String login, String password) async {
    final emailRemote = await remote.logIn(login, password);
    return WaiterEmailEntity(email: emailRemote.email);
  }

  @override
  Future<void> sendCodeRepo(String code) async {
    await remote.sendCode(code);
  }
}
