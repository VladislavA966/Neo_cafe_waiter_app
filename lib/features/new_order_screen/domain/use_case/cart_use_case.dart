import 'package:neo_cafe_24/features/new_order_screen/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/repo/cart_repo.dart';

class CartUseCase {
  final CartRepository repo;

  CartUseCase({required this.repo});
  Future<void> addItemUseCase(CartItemEntity item) async {
    await repo.addItem(item);
  }

  Future<void> removeItemAtUseCase(int index) async {
    await repo.removeItemAt(index);
  }

  Future<CartEntity> getOrCreateCartUseCase() async {
    return await repo.getOrCreateCart();
  }

  Future<List<CartItemEntity>> getItemsUseCase() async {
    return await repo.getItems();
  }

  Future<void> clearCart() async {
    return await repo.clearCart();
  }
}
