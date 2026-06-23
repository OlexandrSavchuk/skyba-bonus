import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/content/data/models/content_page.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ContentRepository(apiClient: ref.watch(apiClientProvider));
});

class ContentRepository {
  final ApiClient _apiClient;

  ContentRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<ContentPage> getPage(String slug) async {
    try {
      final response = await _apiClient.get('/pages/$slug');
      return ContentPage.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити сторінку',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
