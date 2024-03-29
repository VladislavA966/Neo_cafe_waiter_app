// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeModel _$EmployeModelFromJson(Map<String, dynamic> json) => EmployeModel(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$EmployeModelToJson(EmployeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
    };
