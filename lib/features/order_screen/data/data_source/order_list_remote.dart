import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/order_screen/data/models/order_info_model.dart';

abstract class OrdersListRemote {
  Future<List<OrderInfoModel>> getOrders();
}

class OrdersListRomoteImpl implements OrdersListRemote {
  final Dio dio;

  OrdersListRomoteImpl({required this.dio});
  @override
  Future<List<OrderInfoModel>> getOrders() async {
    final responce = await dio.get('/orders/all/');
    List<dynamic> jsonData = responce.data;
    List<OrderInfoModel> orders = jsonData
        .map(
          (json) => OrderInfoModel.fromJson(json),
        )
        .toList();
    if (responce.statusCode == 200 || responce.statusCode == 201) {
      return orders;
    } else {
      throw Exception();
    }
  }
}
