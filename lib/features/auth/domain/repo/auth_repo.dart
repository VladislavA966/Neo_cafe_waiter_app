import 'package:neo_cafe_24/features/auth/domain/entity/waiter_email_entity.dart';

abstract class AuthRepo {
  Future<WaiterEmailEntity> authRepo(String login, String password);
  Future<void> sendCodeRepo(String code);
}
