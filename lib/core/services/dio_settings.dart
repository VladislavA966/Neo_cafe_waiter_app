import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';

class DioSettings {
  final AuthDataSource _storage;
  DioSettings(this._storage) {
    setup();
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://tokyo-backender.org.kg',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  bool _isRefreshingToken = false;

  Future<void> setup() async {
    final interceptors = dio.interceptors;

    interceptors.clear();

    final logInterceptor = LogInterceptor(
      requestBody: true,
      responseBody: true,
    );

    interceptors.add(logInterceptor);

    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.extra['requiresToken'] == true) {
          final token = await _storage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401 && !_isRefreshingToken) {
          _isRefreshingToken = true;
          final refreshToken = await _storage.getRefreshToken();
          if (refreshToken != null) {
            try {
              final response = await dio
                  .post('/token/refresh/', data: {'refresh': refreshToken});
              final newAccessToken = response.data['access'];
              final newRefreshToken = response.data['refresh'];

              await _storage.saveToken(newAccessToken, newRefreshToken);

              _isRefreshingToken = false;

              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newAccessToken';

              final clonedRequest = await dio.request(opts.path,
                  options: Options(method: opts.method, headers: opts.headers),
                  data: opts.data,
                  queryParameters: opts.queryParameters);
              return handler.resolve(clonedRequest);
            } catch (e) {
              _isRefreshingToken = false;
              return handler.reject(error);
            }
          } else {
            _isRefreshingToken = false;
          }
        }
        return handler.next(error);
      },
    ));

    if (kDebugMode) {
      interceptors.add(logInterceptor);
    }
  }
}
