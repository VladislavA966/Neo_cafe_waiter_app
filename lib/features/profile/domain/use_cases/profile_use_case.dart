import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/profile/domain/entities/profile_entity.dart';
import 'package:neo_cafe_24/features/profile/domain/repo/profile_repo.dart';

class ProfileUseCase extends UseCase<ProfileEntity, void> {
  final ProfileRepo repo;

  ProfileUseCase({required this.repo});
  @override
  Future<ProfileEntity> call(void params) async {
    return await repo.getProfileInfo();
  }
}
