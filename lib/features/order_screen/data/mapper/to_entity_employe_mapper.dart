import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/models/employe_model/employe_model.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';

class EmployeMapper extends Mapper<EmployeModel, EmployeEntity> {
  @override
  EmployeEntity mapper(EmployeModel model) {
    return EmployeEntity(username: model.username);
  }
}
