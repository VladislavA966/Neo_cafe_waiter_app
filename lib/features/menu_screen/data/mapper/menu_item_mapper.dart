import 'package:neo_cafe_24/features/menu_screen/data/models/menu_item_model.dart/menu_all_item_model.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/ingredient_entity.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/item_entity.dart';

extension ItemMapper on ItemModel {
  ItemEntity toDomain() {
    return ItemEntity(
      id: id ?? 0,
      name: name ?? '',
      description: description ?? '',
      categoryId: category.id ?? 0,
      categoryName: category.name ?? '',
      itemImage: itemImage ?? '',
      pricePerUnit: pricePerUnit ?? 0,
      branch: branch ?? 0,
      ingredient: ingredients
              ?.map(
                (e) => IngredientEntity(
                  id: e.id,
                  name: e.name,
                  quantity: e.quantity,
                  measurementUnit: e.measurementUnit,
                ),
              )
              .toList() ??
          [],
    );
  }
}
