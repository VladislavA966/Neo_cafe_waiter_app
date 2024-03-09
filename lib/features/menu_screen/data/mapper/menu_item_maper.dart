import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/menu_screen/data/models/menu_item_model.dart/menu_all_item_model.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/ingredient_entity.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/item_entity.dart';

class MenuItemMapper extends Mapper<ItemModel, ItemEntity> {
  @override
  ItemEntity mapper(ItemModel model) {
    return ItemEntity(
        id: model.id ?? 0,
        name: model.name ?? '',
        description: model.description ?? '',
        categoryId: model.category.id ?? 0,
        categoryName: model.category.name ?? '',
        itemImage: model.itemImage ?? '',
        pricePerUnit: model.pricePerUnit ?? 0,
        branch: model.branch ?? 0,
        ingredient: model.ingredients
                ?.map(
                  (ingridient) => IngredientEntity(
                    id: ingridient.id,
                    name: ingridient.name,
                    quantity: ingridient.quantity,
                    measurementUnit: ingridient.measurementUnit,
                  ),
                )
                .toList() ??
            []);
  }
}
