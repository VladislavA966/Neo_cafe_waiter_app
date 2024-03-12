import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neo_cafe_24/core/app/my_app.dart';
import 'package:neo_cafe_24/core/di/dependency_injection.dart';
import 'package:neo_cafe_24/core/di/hive.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/cart_model/cart_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup.initHive();
  final cartBox = await Hive.openBox<CartModel>('cartBox');
  getIt.registerSingleton<Box<CartModel>>(cartBox);
  setUpDependency();
  runApp(
    const MyApp(),
  );
}
