// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiter_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaiterEmailModel _$WaiterEmailModelFromJson(Map<String, dynamic> json) =>
    WaiterEmailModel(
      email: json['waiter_email'] as String,
      csrfToken: json['csrf_token'] as String,
    );

Map<String, dynamic> _$WaiterEmailModelToJson(WaiterEmailModel instance) =>
    <String, dynamic>{
      'csrf_token': instance.csrfToken,
      'waiter_email': instance.email,
    };
