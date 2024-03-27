import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/models/order_info_model.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';

class ToEntityItemMapper extends Mapper<ItemToOrderModel, ItemToOrderEntity> {
  @override
  ItemToOrderEntity mapper(ItemToOrderModel model) {
    return ItemToOrderEntity(
      id: model.id ?? 0,
      item: model.item ?? 0,
      itemName: model.itemName,
      quantity: model.quantity ?? 0,
      totalPrice: model.totalPrice ?? 0,
    );
  }
}
