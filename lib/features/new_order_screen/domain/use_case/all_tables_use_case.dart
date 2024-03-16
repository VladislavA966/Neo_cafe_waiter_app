import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/repo/table_repo.dart';

class AllTableUseCase extends UseCase<List<TableEntity>, void> {
  final TableRepo repo;

  AllTableUseCase({required this.repo});
  @override
  Future<List<TableEntity>> call(void params) async {
    return await repo.getAllTables();
  }
}
