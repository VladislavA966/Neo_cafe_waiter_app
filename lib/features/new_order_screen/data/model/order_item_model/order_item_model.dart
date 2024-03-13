import 'package:json_annotation/json_annotation.dart';
part 'order_item_model.g.dart';

@JsonSerializable()
class ItemOrderModel {
  @JsonKey(name: "item")
  final int item;
  @JsonKey(name: "quantity")
  final int quantity;

  ItemOrderModel({
    required this.item,
    required this.quantity,
  });
  factory ItemOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ItemOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemOrderModelToJson(this);
}
