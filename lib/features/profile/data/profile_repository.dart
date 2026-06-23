import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/profile/data/models/client_profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileRepository(apiClient: apiClient);
});

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<ClientProfile> getProfile() async {
    try {
      final response = await _apiClient.get('/profile');
      return ClientProfile.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data?['message']?.toString() ??
            'Не вдалося завантажити профіль',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<ClientProfile> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.patch(
        '/profile',
        data: data,
      );
      return ClientProfile.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data?['message']?.toString() ??
            'Не вдалося оновити профіль',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> deleteProfile() async {
    try {
      await _apiClient.delete('/profile');
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data?['message']?.toString() ??
            'Не вдалося видалити профіль',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
