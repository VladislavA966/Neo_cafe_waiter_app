import 'package:neo_cafe_24/features/order_screen/data/data_source/order_list_remote.dart';
import 'package:neo_cafe_24/features/order_screen/data/mapper/to_entity_order_mapper.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';
import 'package:neo_cafe_24/features/order_screen/domain/repo/orders_list_repo.dart';

class OrdersListRepoImpl implements OrdersListRepo {
  final OrdersListRemote remote;
  final OrderToEntityMapper orderMapper;

  OrdersListRepoImpl({required this.remote, required this.orderMapper});
  @override
  Future<List<OrderInfoEntity>> getOrders() async {
    final ordersRemote = await remote.getOrders();
    final ordersEntity = ordersRemote
        .map(
          (orderRemote) => orderMapper.mapper(
            orderRemote,
          ),
        )
        .toList();
    return ordersEntity;
  }
}
