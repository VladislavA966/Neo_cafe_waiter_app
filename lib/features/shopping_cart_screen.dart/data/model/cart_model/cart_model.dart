import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/model/cart_item_model/cart_item_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class CartModel extends HiveObject {
  @HiveField(0)
  List<CartItemModel> items;

  CartModel({required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
