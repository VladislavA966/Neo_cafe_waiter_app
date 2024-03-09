import 'package:hive/hive.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/model/cart_item_model/cart_item_model.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/model/cart_model/cart_model.dart';

abstract class CartLocalDataSource {
  Future<void> addItem(CartItemModel item);
  Future<void> removeItemAt(int itemId);
  Future<CartModel> getOrCreateCart();
  Future<List<CartItemModel>> getItems();
  Future<void> clearCart();
  Future<bool> isItemInCart(int itemId);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartModel> cartBox;

  CartLocalDataSourceImpl(this.cartBox);

  @override
  Future<void> removeItemAt(int itemId) async {
    final cart = await getOrCreateCart();

    int itemIndex = cart.items.indexWhere((item) => item.id == itemId);

    if (itemIndex != -1) {
      cart.items[itemIndex].quantity -= 1;

      if (cart.items[itemIndex].quantity <= 0) {
        cart.items.removeAt(itemIndex);
      }

      await cart.save();
    }
  }

  @override
  Future<CartModel> getOrCreateCart() async {
    if (cartBox.isEmpty) {
      final cart = CartModel(items: []);
      await cartBox.add(cart);
      return cart;
    } else {
      return cartBox.values.first;
    }
  }

  @override
  Future<List<CartItemModel>> getItems() async {
    final cart = await getOrCreateCart();
    return cart.items;
  }

  @override
  Future<void> addItem(CartItemModel item) async {
    final cart = await getOrCreateCart();

    int? existingItemIndex = cart.items.indexWhere((i) => i.id == item.id);

    if (existingItemIndex != -1) {
      cart.items[existingItemIndex].quantity += 1;
    } else {
      CartItemModel newItem = CartItemModel(
          id: item.id,
          image: item.image,
          name: item.name,
          quantity: item.quantity,
          price: item.price);
      cart.items.add(newItem);
    }

    await cart.save();
  }

  @override
  Future<void> clearCart() async {
    final cart = await getOrCreateCart();
    cart.items.clear();
    await cart.save();
  }

  @override
  Future<bool> isItemInCart(int itemId) async {
    final cart = await getOrCreateCart();
    int itemIndex = cart.items.indexWhere((item) => item.id == itemId);
    return itemIndex != -1;
  }
}
