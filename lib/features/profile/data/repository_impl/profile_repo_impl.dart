import 'package:neo_cafe_24/features/profile/data/data_source/profile_remote.dart';
import 'package:neo_cafe_24/features/profile/data/mapper/profile_mapper.dart';
import 'package:neo_cafe_24/features/profile/domain/entities/profile_entity.dart';
import 'package:neo_cafe_24/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataImpl profileRemote;
  final ProfileMapper profileMapper;

  ProfileRepoImpl({required this.profileRemote, required this.profileMapper});
  @override
  Future<ProfileEntity> getProfileInfo() async {
    final profileRemoteData = await profileRemote.getProfileInfo();
    final profileEntity = profileMapper.mapper(profileRemoteData);
    return profileEntity;
  }
}
