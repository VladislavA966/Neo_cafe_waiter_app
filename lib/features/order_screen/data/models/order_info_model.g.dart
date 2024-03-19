// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInfoModel _$OrderInfoModelFromJson(Map<String, dynamic> json) =>
    OrderInfoModel(
      id: json['id'] as int?,
      table: json['table'] == null
          ? null
          : TableModel.fromJson(json['table'] as Map<String, dynamic>),
      orderStatus: json['order_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      completedAt: json['completed_at'] as String?,
      branch: json['branch'] as int?,
      orderType: json['order_type'] as String?,
      totalSum: json['total_sum'] as int?,
      employee: json['employee'] as int?,
      items: (json['ITO'] as List<dynamic>)
          .map((e) => ItemToOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderInfoModelToJson(OrderInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'table': instance.table,
      'order_status': instance.orderStatus,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'completed_at': instance.completedAt,
      'branch': instance.branch,
      'order_type': instance.orderType,
      'total_sum': instance.totalSum,
      'employee': instance.employee,
      'ITO': instance.items,
    };

ItemToOrderModel _$ItemToOrderModelFromJson(Map<String, dynamic> json) =>
    ItemToOrderModel(
      id: json['id'] as int?,
      item: json['item'] as int?,
      quantity: json['quantity'] as int?,
      totalPrice: json['total_price'] as int?,
    );

Map<String, dynamic> _$ItemToOrderModelToJson(ItemToOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
    };
