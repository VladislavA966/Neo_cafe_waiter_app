import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/models/employe_model/employe_model.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';

class EmployeMapper extends Mapper<EmployeeModel, EmployeEntity> {
  @override
  EmployeEntity mapper(EmployeeModel model) {
    return EmployeEntity(username: model.user.firstName ?? '');
  }
}
