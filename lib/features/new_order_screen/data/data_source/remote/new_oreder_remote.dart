import 'dart:convert';

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
    final jsonData = order.toJson();
   
    await dio.post(
      '/orders/add/',
      data: json.encode(jsonData),
      options: Options(
        extra: {"requiresToken": true},
      ),
    );
  }
}
