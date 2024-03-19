import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/table_model/table_model.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';

class ToEntityTableMapper extends Mapper<TableModel, TableEntity> {
  @override
  TableEntity mapper(TableModel model) {
    return TableEntity(
      id: model.id ?? 0,
      tableNumbe: model.tableNumber ?? 0,
      isAvailable: model.isAvailable ?? true,
      branch: model.id ?? 0,
    );
  }
}
