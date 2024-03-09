import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/category_entity.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/repo/category_repo.dart';

class CategoryUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final MenuRepo repo;

  CategoryUseCase({required this.repo});
  @override
  Future<List<CategoryEntity>> call(NoParams params) async {
    return await repo.getAllCategories();
  }
}

class NoParams {}
