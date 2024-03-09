import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/auth/domain/repo/auth_repo.dart';

class SendCodeUseCase extends UseCase<void, SendCodeParams> {
  final AuthRepo repo;

  SendCodeUseCase({required this.repo});
  @override
  Future<void> call(SendCodeParams params) async {
    await repo.sendCodeRepo(params.code);
  }
}

class SendCodeParams {
  final String code;

  SendCodeParams({required this.code});
}
