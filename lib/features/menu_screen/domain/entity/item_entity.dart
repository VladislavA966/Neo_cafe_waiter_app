import 'package:neo_cafe_24/features/menu_screen/domain/entity/ingredient_entity.dart';

class ItemEntity {
  final int id;

  final String name;

  final String description;
  final int categoryId;

  final String categoryName;

  final String itemImage;

  final int pricePerUnit;

  final int branch;
  final List<IngredientEntity> ingredient;

  ItemEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.categoryId,
      required this.categoryName,
      required this.itemImage,
      required this.pricePerUnit,
      required this.branch,
      required this.ingredient});
}
