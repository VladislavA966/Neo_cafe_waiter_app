import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/data_source/local/cart_local_data_source.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/mapper/item_order_mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/mapper/table_mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/data_source/remote/new_oreder_remote.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/order_model/order_model.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/repo/order_repo.dart';

class NewOrderRepositoryImpl implements NewOrderRepo {
  final NewOrderRemote orderRemote;
  final CartLocalDataSource cartLocal;
  final AuthDataSource authLocal;
  final ItemOrderMapper itemMapper;
  final TableMapper tableMapper;

  NewOrderRepositoryImpl({
    required this.orderRemote,
    required this.itemMapper,
    required this.tableMapper,
    required this.cartLocal,
    required this.authLocal,
  });

  @override
  Future<void> sendNewOrder(TableEntity table) async {
    final items = await cartLocal.getItems();
    final orderItems = itemMapper.mapper(items);
    final branchId = await authLocal.getBranchId();
    final order = OrderModel(
      table: tableMapper.mapper(table),
      branch: branchId ?? 1,
      ito: orderItems,
    );
    await orderRemote.sendNewOrder(order);
  }
}
