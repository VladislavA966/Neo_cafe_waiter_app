import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/item_entity.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/repo/category_repo.dart';

class AllItemsUseCase extends UseCase<List<ItemEntity>, CategoryParams> {
  final MenuRepo repo;

  AllItemsUseCase({required this.repo});
  @override
  Future<List<ItemEntity>> call(CategoryParams params) async {
    return await repo.getAllMenuItems(params.id);
  }
}

class CategoryParams {
  final int id;

  CategoryParams({required this.id});
}
