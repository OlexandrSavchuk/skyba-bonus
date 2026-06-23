import 'package:dio/dio.dart';
import 'package:skyba_bonus/core/storage/secure_storage.dart';

typedef OnUnauthorized = void Function();

class AuthInterceptor extends Interceptor {
  final SecureStorageService secureStorage;
  final OnUnauthorized? onUnauthorized;

  AuthInterceptor({required this.secureStorage, this.onUnauthorized});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only clear tokens on 401 for non-auth endpoints (avoid clearing during login)
    if (err.response?.statusCode == 401) {
      final path = err.requestOptions.path;
      if (!path.contains('/auth/login') && !path.contains('/auth/register')) {
        await secureStorage.clearTokens();
        onUnauthorized?.call();
      }
    }
    handler.next(err);
  }
}
