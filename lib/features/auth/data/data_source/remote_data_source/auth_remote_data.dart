import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/auth/data/models/token_model.dart';
import 'package:neo_cafe_24/features/auth/data/models/waiter_email_model.dart';

abstract class AuthRemote {
  Future<WaiterEmailModel> logIn(String userName, String password);
  Future<TokenModel> sendCode(String confirmationCode);
}

class AuthRemoteImpl extends AuthRemote {
  final AuthDataSource local;
  final Dio dio;

  AuthRemoteImpl({required this.dio, required this.local});
  @override
  Future<WaiterEmailModel> logIn(String userName, String password) async {
    final responce = await dio.post('/waiter/check-username-login/',
        data: {"username": userName, "password": password});
    final model = WaiterEmailModel.fromJson(responce.data);
    if (responce.statusCode == 200 || responce.statusCode == 201) {
      await local.saveEmailAndToken(model.email, model.csrfToken);
      return model;
    } else {
      throw Exception();
    }
  }

  @override
  Future<TokenModel> sendCode(String confirmationCode) async {
    final csrfToken = await local.getScrfToken();
    final email = await local.getWaireEmail();
    final responce = await dio.post(
      '/waiter/login/',
      data: {
        "email": email,
        "confirmation_code": confirmationCode,
      },
      options: Options(
        headers: {
          'X-CSRFTOKEN': csrfToken,
        },
      ),
    );
    final model = TokenModel.fromJson(responce.data);
    if (responce.statusCode == 200 || responce.statusCode == 201) {
      await local.saveToken(
        model.accessToken,
        model.refreshToken,
      );
      await local.saveBranchId(model.branchId, model.userId);
      return model;
    } else {
      throw Exception();
    }
  }
}
