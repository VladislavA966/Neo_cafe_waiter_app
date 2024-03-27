import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/menu_screen/data/models/category/category_model.dart';
import 'package:neo_cafe_24/features/menu_screen/data/models/menu_item_model.dart/menu_all_item_model.dart';

abstract class MenuRemote {
  Future<List<CategoryModel>> getAllCategories();
  Future<List<ItemModel>> getAllItems(int categoryId);
}

class MenuRemoteImpl implements MenuRemote {
  final AuthDataSource local;
  final Dio dio;

  MenuRemoteImpl({required this.dio, required this.local});
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await dio.get(
      '/menu/category/all/',
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      List<CategoryModel> categories =
          jsonData.map((json) => CategoryModel.fromJson(json)).toList();
      return categories;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ItemModel>> getAllItems(int categoyID) async {
    final branchId = await local.getBranchId();
    final responce = await dio.get(
      '/branch-menu/$branchId/$categoyID/',
    );
    List<dynamic> jsonData = responce.data;
    List<ItemModel> items =
        jsonData.map((json) => ItemModel.fromJson(json)).toList();
    return items;
  }
}
