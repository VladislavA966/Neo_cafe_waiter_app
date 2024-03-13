import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/order_item_model/order_item_model.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/table_model/table_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "table")
  final TableModel table;
  @JsonKey(name: "branch")
  final int branch;
  @JsonKey(name: "order_type")
  final String orderType;
  @JsonKey(name: "ITO")
  final List<ItemOrderModel> ito;

  OrderModel(
      {required this.table,
      required this.branch,
      required this.orderType,
      required this.ito});
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
