import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/table_model/table_model.dart';
import 'package:neo_cafe_24/features/order_screen/data/models/employe_model/employe_model.dart';

part 'order_info_model.g.dart';

@JsonSerializable()
class OrderInfoModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "order_number")
  final int? orderNumber;
  @JsonKey(name: "table")
  final TableModel? table;
  @JsonKey(name: "order_status")
  final String? orderStatus;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "completed_at")
  final String? completedAt;
  @JsonKey(name: "branch")
  final int? branch;
  @JsonKey(name: "order_type")
  final String? orderType;
  @JsonKey(name: "total_sum")
  final int? totalSum;
  @JsonKey(name: "employee_profile")
  final EmployeModel employee;
  @JsonKey(name: "ITO")
  final List<ItemToOrderModel> items;

  factory OrderInfoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderInfoModelFromJson(json);

  OrderInfoModel(
      {required this.id,
      required this.orderNumber,
      required this.table,
      required this.orderStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.completedAt,
      required this.branch,
      required this.orderType,
      required this.totalSum,
      required this.employee,
      required this.items});
  Map<String, dynamic> toJson() => _$OrderInfoModelToJson(this);
}

@JsonSerializable()
class ItemToOrderModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "item")
  final int? item;
  @JsonKey(name: "item_name")
  final String itemName;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "total_price")
  final int? totalPrice;

  ItemToOrderModel({
    required this.id,
    required this.item,
    required this.itemName,
    required this.quantity,
    required this.totalPrice,
  });

  factory ItemToOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ItemToOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToOrderModelToJson(this);
}
