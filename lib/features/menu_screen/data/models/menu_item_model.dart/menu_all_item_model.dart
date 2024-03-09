import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:neo_cafe_24/features/menu_screen/data/models/category/category_model.dart';

part 'menu_all_item_model.g.dart';

@JsonSerializable()
class ItemModel extends HiveObject {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "item_image")
  final String? itemImage;
  @JsonKey(name: "price_per_unit")
  final int? pricePerUnit;
  @JsonKey(name: "branch")
  final int? branch;
  @JsonKey(name: "category")
  final CategoryModel category;
  @JsonKey(name: "ingredients")
  final List<IngredientModel>? ingredients;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.itemImage,
    required this.pricePerUnit,
    required this.branch,
    required this.ingredients,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}

@JsonSerializable()
class IngredientModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "quantity")
  final int quantity;

  @JsonKey(name: "measurement_unit")
  final String measurementUnit;

  IngredientModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.measurementUnit,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);
}



// flutter pub run build_runner build
