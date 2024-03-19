import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';

abstract class OrdersListRepo {
  Future<List<OrderInfoEntity>> getOrders();
}
