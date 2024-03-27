import 'package:neo_cafe_24/features/profile/domain/entities/schedule_entity.dart';

class ProfileEntity {
  final int id;
  final String userName;
  final String password;
  final String firstName;
  final String? lastName;
  final String email;
  final String userType;
  final int branch;
  final String branchName;
  final List<ScheduleEntity> employeeSchedules;

  ProfileEntity(
      {required this.id,
      required this.userName,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.userType,
      required this.branch,
      required this.branchName,
      required this.employeeSchedules});
}
