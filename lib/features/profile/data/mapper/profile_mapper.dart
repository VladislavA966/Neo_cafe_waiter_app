import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/profile/data/mapper/schedile_mapper.dart';
import 'package:neo_cafe_24/features/profile/data/models/profile_model/profile_model.dart';
import 'package:neo_cafe_24/features/profile/domain/entities/profile_entity.dart';

class ProfileMapper extends Mapper<ProfileModel, ProfileEntity> {
  final ShceduleMapper scheduleMapper;

  ProfileMapper({required this.scheduleMapper});
  @override
  ProfileEntity mapper(ProfileModel model) {
    return ProfileEntity(
      id: model.id ?? 0,
      userName: model.userName,
      password: model.password ?? '',
      firstName: model.firstName ?? '',
      lastName: model.lastName ?? '',
      email: model.email ?? '',
      userType: model.userType ?? '',
      branch: model.branch ?? 0,
      branchName: model.branchName ?? '',
      employeeSchedules: model.employeeSchedules
              ?.map((schedule) => scheduleMapper.mapper(schedule))
              .toList() ??
          [],
    );
  }
}
