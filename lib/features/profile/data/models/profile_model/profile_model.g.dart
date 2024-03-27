// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'] as int?,
      userName: json['username'] as String,
      password: json['password'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      userType: json['user_type'] as String?,
      branch: json['branch'] as int?,
      branchName: json['branch_name'] as String?,
      employeeSchedules: (json['employee_schedules'] as List<dynamic>?)
          ?.map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'user_type': instance.userType,
      'branch': instance.branch,
      'branch_name': instance.branchName,
      'employee_schedules': instance.employeeSchedules,
    };
