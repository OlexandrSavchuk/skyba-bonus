import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _clientIdKey = 'client_id';
  static const _companyIdKey = 'company_id';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  Future<void> setAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getClientId() async {
    return _storage.read(key: _clientIdKey);
  }

  Future<void> setClientId(String clientId) async {
    await _storage.write(key: _clientIdKey, value: clientId);
  }

  Future<String?> getCompanyId() async {
    return _storage.read(key: _companyIdKey);
  }

  Future<void> setCompanyId(String companyId) async {
    await _storage.write(key: _companyIdKey, value: companyId);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _clientIdKey);
    await _storage.delete(key: _companyIdKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
