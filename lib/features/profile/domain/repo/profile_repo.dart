import 'package:neo_cafe_24/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepo {
  Future<ProfileEntity> getProfileInfo();
}