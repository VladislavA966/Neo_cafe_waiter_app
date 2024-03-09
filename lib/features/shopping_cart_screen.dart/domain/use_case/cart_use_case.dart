import 'package:neo_cafe_24/features/shopping_cart_screen.dart/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/domain/repo/cart_repo.dart';

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

  Future<bool> isItemIncart(int itemId) async {
    return await repo.isItemInCart(itemId);
  }
}
