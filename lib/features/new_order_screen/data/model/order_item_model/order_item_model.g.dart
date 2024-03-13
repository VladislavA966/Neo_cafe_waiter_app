// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrderModel _$ItemOrderModelFromJson(Map<String, dynamic> json) =>
    ItemOrderModel(
      item: json['item'] as int,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$ItemOrderModelToJson(ItemOrderModel instance) =>
    <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
    };
