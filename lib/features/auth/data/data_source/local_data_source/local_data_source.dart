import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDataSource {
  final _storage = const FlutterSecureStorage();
  //Сохранение токенов
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
//Сохранение почты и csrf токена
  Future<void> saveEmailAndToken(String email, String csrfToken) async {
    await _storage.write(key: 'waiter_email', value: email);
    return await _storage.write(key: 'csrf_token', value: csrfToken);
  }

  Future<String?> getWaireEmail() async {
    return await _storage.read(key: 'waiter_email');
  }

  Future<String?> getScrfToken() async {
    return await _storage.read(key: 'csrf_token');
  }
//Сохранение id филиала
  Future<void> saveBranchId(int branchId) async {
    await _storage.write(key: 'branch_id', value: branchId.toString());
  }

  Future<int?> getBranchId() async {
    final String? branchIdStr = await _storage.read(key: 'branch_id');
    if (branchIdStr != null) {
      return int.tryParse(branchIdStr);
    }
    return null;
  }
}
