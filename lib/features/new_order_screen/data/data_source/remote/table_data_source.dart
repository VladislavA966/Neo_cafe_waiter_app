import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/table_model/table_model.dart';

abstract class TableRemote {
  Future<List<TableModel>> getAllTables();
  Future<TableModel> getCurrentTable(int id);
}

class TableRemoteImpl implements TableRemote {
  final Dio dio;
  final AuthDataSource local;

  TableRemoteImpl({required this.dio, required this.local});
  @override
  Future<List<TableModel>> getAllTables() async {
    final branchId = await local.getBranchId();
    final response = await dio.get(
      '/tables/branch/$branchId',
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      List<TableModel> tables =
          jsonData.map((json) => TableModel.fromJson(json)).toList();
      return tables;
    } else {
      throw Exception();
    }
  }

  @override
  Future<TableModel> getCurrentTable(int id) async {
    final responce = await dio.get('/table/$id/');
    if (responce.statusCode == 200 || responce.statusCode == 201) {
      return TableModel.fromJson(responce.data);
    } else {
      throw Exception();
    }
  }
}
