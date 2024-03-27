import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/profile/data/models/profile_model/profile_model.dart';

abstract class ProfileRemoteData {
  Future<ProfileModel> getProfileInfo();
}

class ProfileRemoteDataImpl implements ProfileRemoteData {
  final Dio dio;
  final AuthDataSource localData;

  ProfileRemoteDataImpl({required this.dio, required this.localData});
  @override
  Future<ProfileModel> getProfileInfo() async {
    final userId = await localData.getUserId();

    final responce = await dio.get('/employee/$userId/');

    if (responce.statusCode == 200 || responce.statusCode == 201) {
      return ProfileModel.fromJson(responce.data);
    } else {
      throw Exception();
    }
  }
}
