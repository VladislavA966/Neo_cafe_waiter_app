import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/data_source/local/cart_local_data_source.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/model/cart_item_model/cart_item_model.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/domain/repo/cart_repo.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource data;

  CartRepositoryImpl({required this.data});

  @override
  Future<void> addItem(CartItemEntity item) async {
    final itemModel = CartItemModel(
      id: item.id,
      name: item.name,
      price: item.price,
      quantity: item.quantity,
      image: item.image,
    );
    await data.addItem(itemModel);
  }

  @override
  Future<List<CartItemEntity>> getItems() async {
    final itemsModel = await data.getItems();

    return itemsModel
        .map((item) => CartItemEntity(
              id: item.id,
              name: item.name,
              price: item.price,
              quantity: item.quantity,
              image: item.image ?? '',
            ))
        .toList();
  }

  @override
  Future<CartEntity> getOrCreateCart() async {
    final cartModel = await data.getOrCreateCart();

    return CartEntity(
      items: cartModel.items
          .map((item) => CartItemEntity(
                id: item.id,
                name: item.name,
                price: item.price,
                quantity: item.quantity,
                image: item.image ?? '',
              ))
          .toList(),
    );
  }

  @override
  Future<void> removeItemAt(int itemId) async {
    await data.removeItemAt(itemId);
  }

  @override
  Future<void> clearCart() async {
    await data.clearCart();
  }

  @override
  Future<bool> isItemInCart(int itemId) async {
    return await isItemInCart(itemId);
  }
}
