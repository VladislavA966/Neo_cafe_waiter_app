import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/cart_item_model/cart_item_model.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/order_item_model/order_item_model.dart';

class ItemOrderMapper
    extends Mapper<List<CartItemModel>, List<ItemOrderModel>> {
  @override
  List<ItemOrderModel> mapper(List<CartItemModel> model) {
    final itemOrderModel = model
        .map(
          (itemEntity) => ItemOrderModel(
            item: itemEntity.id,
            quantity: itemEntity.quantity,
          ),
        )
        .toList();
    return itemOrderModel;
  }
}
