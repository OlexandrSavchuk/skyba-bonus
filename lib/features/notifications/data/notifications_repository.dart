import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/notifications/data/models/app_notification.dart';

final notificationsRepositoryProvider =
    Provider<NotificationsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NotificationsRepository(apiClient: apiClient);
});

class NotificationsRepository {
  final ApiClient _apiClient;

  NotificationsRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<AppNotification>> getNotifications() async {
    try {
      final response = await _apiClient.get('/notifications');
      final raw = response.data;
      final List<dynamic> data = raw is List
          ? raw
          : (raw['data'] as List<dynamic>?)
              ?? (raw['items'] as List<dynamic>?)
              ?? [];
      return data
          .map((item) =>
              AppNotification.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити сповіщення',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _apiClient.put('/notifications/$id/read');
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося позначити сповіщення як прочитане',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
