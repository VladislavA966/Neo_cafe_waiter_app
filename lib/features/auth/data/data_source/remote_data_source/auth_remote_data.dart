import 'package:dio/dio.dart';
import 'package:neo_cafe_24/features/auth/data/models/waiter_email_model.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_remote_data.g.dart';

@RestApi()
abstract class AuthRemote {
  factory AuthRemote(Dio dio, {String baseUrl}) = _AuthRemote;

  @POST('/waiter/check-username-login/')
  Future<WaiterEmailModel> authRemote(@Body() Map<String, dynamic> data);
  @POST('/waiter/login')
  Future<void> sendCodeRemote(@Body() Map<String, dynamic> data);
}
