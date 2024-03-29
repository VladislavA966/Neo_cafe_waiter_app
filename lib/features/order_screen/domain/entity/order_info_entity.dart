import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';

class OrderInfoEntity {
  final int id;
  final int orderNumber;
  final TableEntity? table;
  final String orderStatus;
  final String createdAt;
  final String updatedAt;
  final String completedAt;
  final int branch;
  final String orderType;
  final int totalSum;
  final EmployeEntity? employee;
  final List<ItemToOrderEntity> items;

  OrderInfoEntity(
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
}

class ItemToOrderEntity {
  final int id;
  final int item;
  final String itemName;
  final int quantity;
  final int totalPrice;

  ItemToOrderEntity({
    required this.id,
    required this.item,
    required this.itemName,
    required this.quantity,
    required this.totalPrice,
  });
}

class EmployeEntity {
  final String username;

  EmployeEntity({required this.username});
}
