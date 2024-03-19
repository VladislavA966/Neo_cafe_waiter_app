// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      message: json['message'] as String,
      refreshToken: json['refresh_token'] as String,
      accessToken: json['access_token'] as String,
      branchId: json['branch_id'] as int,
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'refresh_token': instance.refreshToken,
      'access_token': instance.accessToken,
      'branch_id': instance.branchId,
    };
