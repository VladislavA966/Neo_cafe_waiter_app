import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';

abstract class TableRepo {
  Future<List<TableEntity>> getAllTables();
  Future<TableEntity> getCurrentTable(int id);
}
