import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cafe_24/features/profile/data/models/schedile_model/schedile_model.dart';
part 'employe_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "user")
  final UserModel user;

  EmployeeModel({required this.id, required this.user});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "user_name")
  final String? username;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "user_type")
  final String? userType;
  @JsonKey(name: "branch")
  final int? branch;
  @JsonKey(name: "branch_name")
  final String? branchName;
  @JsonKey(name: "employee_schedules")
  final List<ScheduleModel> employeeSchedules;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.firstName,
    this.lastName,
    required this.email,
    required this.userType,
    required this.branch,
    required this.branchName,
    required this.employeeSchedules,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
