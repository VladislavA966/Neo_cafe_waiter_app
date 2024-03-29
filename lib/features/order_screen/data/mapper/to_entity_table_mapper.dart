import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/table_model/table_model.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';

class ToEntityTableMapper extends Mapper<TableModel, TableEntity> {
  @override
  TableEntity mapper(TableModel model) {
    return TableEntity(
      id: model.id,
      tableNumbe: model.tableNumber,
      isAvailable: model.isAvailable,
      branch: model.id,
    );
  }
}
