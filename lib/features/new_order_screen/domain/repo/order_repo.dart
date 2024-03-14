import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';

abstract class NewOrderRepo {
  Future<void> sendNewOrder(TableEntity entity);
}
