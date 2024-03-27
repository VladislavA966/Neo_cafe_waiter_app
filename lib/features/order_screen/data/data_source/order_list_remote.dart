import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/order_screen/data/models/order_info_model.dart';

abstract class OrdersListRemote {
  Future<List<OrderInfoModel>> getOrders();
  Future<OrderInfoModel> getOrderInfo(int table);
}

class OrdersListRomoteImpl implements OrdersListRemote {
  final AuthDataSource local;
  final Dio dio;

  OrdersListRomoteImpl({required this.dio, required this.local});
  @override
  Future<List<OrderInfoModel>> getOrders() async {
    final branchId = await local.getBranchId();
    final responce = await dio.get('/orders/all/$branchId/');
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

  @override
  Future<OrderInfoModel> getOrderInfo(int table) async {
    final branchId = await local.getBranchId();
    final responce = await dio.get('/orders/$branchId/detail/$table/');

    if (responce.statusCode == 200 || responce.statusCode == 201) {
      return OrderInfoModel.fromJson(responce.data);
    } else {
      throw Exception();
    }
  }
}
