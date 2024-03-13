// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      table: TableModel.fromJson(json['table'] as Map<String, dynamic>),
      branch: json['branch'] as int,
      orderType: json['order_type'] as String,
      ito: (json['ITO'] as List<dynamic>)
          .map((e) => ItemOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'table': instance.table,
      'branch': instance.branch,
      'order_type': instance.orderType,
      'ITO': instance.ito,
    };
