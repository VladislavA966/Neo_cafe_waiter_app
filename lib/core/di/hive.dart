import 'package:hive_flutter/hive_flutter.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/model/cart_item_model/cart_item_model.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/model/cart_model/cart_model.dart';

class HiveSetup {
  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CartItemModelAdapter());
    Hive.registerAdapter(CartModelAdapter());

    await Hive.openBox<CartItemModel>('itemModels');
    await Hive.openBox<CartModel>('cartModels');
  }
}
