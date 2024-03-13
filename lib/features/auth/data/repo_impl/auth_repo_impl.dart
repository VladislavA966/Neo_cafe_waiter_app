import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/remote_data_source/auth_remote_data.dart';
import 'package:neo_cafe_24/features/auth/domain/entity/waiter_email_entity.dart';
import 'package:neo_cafe_24/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemote remote;
  final AuthDataSource local;

  AuthRepoImpl({required this.remote, required this.local});
  @override
  Future<WaiterEmailEntity> authRepo(String username, String password) async {
    final remoteData = await remote.authRemote(
      {"username": username, "password": password},
    );
    await local.saveToken('accessToken', 'refreshToken');
    await local.saveWaiterEmail(remoteData.email);
    return WaiterEmailEntity(email: remoteData.email);
  }

  @override
  Future<void> sendCodeRepo(String code) async {
    final email = await local.getWaireEmail();
    await remote.sendCodeRemote(
      {
        "email": email,
        "confirmation_code": code,
      },
    );
  }
}
