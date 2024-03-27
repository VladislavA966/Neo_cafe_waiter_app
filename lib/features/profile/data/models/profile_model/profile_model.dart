import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cafe_24/features/profile/data/models/schedile_model/schedile_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final int? id;
  @JsonKey(name: "username")
  final String userName;
  final String? password;
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  final String? email;
  @JsonKey(name: "user_type")
  final String? userType;
  final int? branch;
  @JsonKey(name: "branch_name")
  final String? branchName;
  @JsonKey(name: "employee_schedules")
  final List<ScheduleModel>? employeeSchedules;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileModel(
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
