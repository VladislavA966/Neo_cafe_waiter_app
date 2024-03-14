import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/order_model/order_model.dart';

abstract class NewOrderRemote {
  Future<void> sendNewOrder(OrderModel order);
}

class NewOrderRemoteImpl implements NewOrderRemote {
  final Dio dio;

  NewOrderRemoteImpl({required this.dio});
  @override
  Future<void> sendNewOrder(OrderModel order) async {
    await dio.get(
      '/orders/add/',
      queryParameters: order.toJson(),
    );
  }
}
