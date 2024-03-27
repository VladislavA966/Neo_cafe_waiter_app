import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';
import 'package:neo_cafe_24/features/order_screen/domain/repo/orders_list_repo.dart';

class OrderInfoUseCase extends UseCase<OrderInfoEntity, TableParams> {
  final OrdersListRepo repo;

  OrderInfoUseCase({required this.repo});
  @override
  Future<OrderInfoEntity> call(TableParams params) async {
    return await repo.getOrderInfo(params.tableNumber);
     
  }

}



class TableParams {
 final int tableNumber;

  TableParams({required this.tableNumber});
}