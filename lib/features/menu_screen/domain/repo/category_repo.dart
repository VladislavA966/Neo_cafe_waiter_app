import 'package:neo_cafe_24/features/menu_screen/domain/entity/category_entity.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/item_entity.dart';

abstract class MenuRepo {
  Future<List<CategoryEntity>> getAllCategories();
  Future<List<ItemEntity>> getAllMenuItems(int categoryId);
}
