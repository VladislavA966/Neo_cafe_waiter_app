import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDataSource {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<void> deleteAllTokens() async {
    await _storage.deleteAll();
  }

  Future<void> saveWaiterEmail(String email) async {
    await _storage.write(key: 'waiter_email', value: email);
  }

  Future<String?> getWaireEmail() async {
    return await _storage.read(key: 'waiter_email');
  }
}
