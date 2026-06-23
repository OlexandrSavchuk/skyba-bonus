import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/promotions/data/models/banner.dart';
import 'package:skyba_bonus/features/promotions/data/models/promotion.dart';

final promotionsRepositoryProvider = Provider<PromotionsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PromotionsRepository(apiClient: apiClient);
});

class PromotionsRepository {
  final ApiClient _apiClient;

  PromotionsRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<Promotion>> getPromotions() async {
    try {
      final response = await _apiClient.get('/promotions');
      final raw = response.data;
      final List<dynamic> data = raw is List
          ? raw
          : (raw['data'] as List<dynamic>?)
              ?? (raw['items'] as List<dynamic>?)
              ?? [];
      return data
          .map((item) => Promotion.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити акції',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Promotion> getPromotion(String id) async {
    try {
      final response = await _apiClient.get('/promotions/$id');
      return Promotion.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити акцію',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<List<PromoBanner>> getBanners() async {
    try {
      final response = await _apiClient.get('/banners');
      final raw = response.data;
      final List<dynamic> data = raw is List
          ? raw
          : (raw['data'] as List<dynamic>?)
              ?? (raw['items'] as List<dynamic>?)
              ?? [];
      return data
          .map((item) => PromoBanner.fromJson(item as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити банери',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
