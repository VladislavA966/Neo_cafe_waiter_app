import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CartItemModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? image;

  @HiveField(2)
  final String name;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  final int price;

  CartItemModel({
    required this.id,
    this.image,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
