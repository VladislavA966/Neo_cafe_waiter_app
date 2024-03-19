import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';
import 'package:neo_cafe_24/features/order_screen/domain/repo/orders_list_repo.dart';

class OrdersListUseCase extends UseCase<List<OrderInfoEntity>, void> {
  final OrdersListRepo repo;

  OrdersListUseCase({required this.repo});
  @override
  Future<List<OrderInfoEntity>> call(void params) async {
    return await repo.getOrders();
  }
}
