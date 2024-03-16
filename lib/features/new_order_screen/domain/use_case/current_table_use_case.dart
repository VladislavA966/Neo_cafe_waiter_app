import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/repo/table_repo.dart';

class CurrentTableUseCase extends UseCase<TableEntity, int> {
  final TableRepo repo;

  CurrentTableUseCase({required this.repo});
  @override
  Future<TableEntity> call(int params) async {
    return await repo.getCurrentTable(params);
  }
}
