import 'package:neo_cafe_24/features/new_order_screen/domain/entity/cart_item_entity.dart';

abstract class CartRepository {
  Future<void> addItem(CartItemEntity item);
  Future<void> removeItemAt(int itemId);
  Future<CartEntity> getOrCreateCart();
  Future<List<CartItemEntity>> getItems();
  Future<void> clearCart();
  
}
