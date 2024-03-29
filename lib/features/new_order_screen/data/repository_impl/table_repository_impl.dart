import 'package:neo_cafe_24/features/new_order_screen/data/data_source/remote/table_data_source.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/repo/table_repo.dart';

class TableRepositoryImpl implements TableRepo {
  final TableRemote remote;

  TableRepositoryImpl({required this.remote});
  @override
  Future<List<TableEntity>> getAllTables() async {
    final tablesRemote = await remote.getAllTables();
    final tablesEntity = tablesRemote
        .map(
          (table) => TableEntity(
            id: table.id,
            tableNumbe: table.tableNumber,
            isAvailable: table.isAvailable,
            branch: table.branch,
          ),
        )
        .toList();
    return tablesEntity;
  }

  @override
  Future<TableEntity> getCurrentTable(int id) async {
    final tableRemote = await remote.getCurrentTable(id);
    final tableEntity = TableEntity(
      id: tableRemote.id,
      tableNumbe: tableRemote.tableNumber,
      isAvailable: tableRemote.isAvailable,
      branch: tableRemote.branch,
    );

    return tableEntity;
  }
}
