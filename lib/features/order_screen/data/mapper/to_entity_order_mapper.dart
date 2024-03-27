import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/mapper/to_entity_item_mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/mapper/to_entity_table_mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/models/order_info_model.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';

class OrderToEntityMapper extends Mapper<OrderInfoModel, OrderInfoEntity> {
  final ToEntityTableMapper tableMapper;
  final ToEntityItemMapper itemMapper;

  OrderToEntityMapper({required this.tableMapper, required this.itemMapper});
  @override
  OrderInfoEntity mapper(OrderInfoModel model) {
    return OrderInfoEntity(
      id: model.id ?? 0,
      orderNumber: model.orderNumber ?? 0,
      table: model.table != null ? tableMapper.mapper(model.table!) : null,
      orderStatus: model.orderStatus ?? '',
      createdAt: model.createdAt ?? '',
      updatedAt: model.updatedAt ?? '',
      completedAt: model.updatedAt ?? '',
      branch: model.branch ?? 1,
      orderType: model.orderType ?? '',
      totalSum: model.totalSum ?? 0,
      employee: model.employee ?? 1,
      items: model.items
          .map(
            (item) => itemMapper.mapper(
              item,
            ),
          )
          .toList(),
    );
  }
}
