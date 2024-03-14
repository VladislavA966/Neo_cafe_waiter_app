import 'package:neo_cafe_24/core/use_case/use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/repo/order_repo.dart';

class NewOrderUseCase extends UseCase<void, TableEntity> {
  final NewOrderRepo repo;

  NewOrderUseCase({required this.repo});
  @override
  Future<void> call(TableEntity params) async {
    await repo.sendNewOrder(params);
  }
}
