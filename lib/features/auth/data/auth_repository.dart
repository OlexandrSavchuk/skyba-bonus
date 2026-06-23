import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/auth/data/models/auth_response.dart';
import 'package:skyba_bonus/features/auth/data/models/login_request.dart';
import 'package:skyba_bonus/features/auth/data/models/register_request.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient: apiClient);
});

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException(
          message: 'Невірний логін або пароль',
        );
      }
      throw NetworkException(
        message: e.message ?? 'Помилка мережі',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _apiClient.post(
        '/auth/register',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data?['message']?.toString() ??
            'Помилка реєстрації',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> resetPassword(String identifier) async {
    try {
      await _apiClient.post(
        '/auth/reset-password',
        data: {'identifier': identifier.trim()},
      );
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data?['message']?.toString() ??
            'Помилка відновлення паролю',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout');
    } catch (_) {
      // Logout locally even if server call fails
    }
  }
}
