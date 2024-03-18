import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/table_model/table_model.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';

class TableMapper extends Mapper<TableEntity, TableModel> {
  @override
  TableModel mapper(TableEntity model) {
    return TableModel(
      id: model.id,
      tableNumber: model.tableNumbe,
      isAvailable: model.isAvailable,
      branch: model.branch,
    );
  }
}
