// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) => TableModel(
      id: json['id'] as int,
      tableNumber: json['table_number'] as int,
      isAvailable: json['is_available'] as bool,
      branch: json['branch'] as int,
    );

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'table_number': instance.tableNumber,
      'is_available': instance.isAvailable,
      'branch': instance.branch,
    };
