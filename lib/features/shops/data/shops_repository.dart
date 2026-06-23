import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/shops/data/models/shop.dart';

final shopsRepositoryProvider = Provider<ShopsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ShopsRepository(apiClient: apiClient);
});

class ShopsRepository {
  final ApiClient _apiClient;

  ShopsRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<Shop>> getShops({String? companyId}) async {
    try {
      final path = companyId != null
          ? '/shops?companyId=$companyId'
          : '/shops';
      final response = await _apiClient.get(path);
      final List<dynamic> data = response.data is List
          ? response.data as List<dynamic>
          : (response.data['data'] as List<dynamic>?)
              ?? (response.data['items'] as List<dynamic>?)
              ?? [];
      return data
          .map((item) => Shop.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити магазини',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Shop> getShop(String id) async {
    try {
      final response = await _apiClient.get('/shops/$id');
      return Shop.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити магазин',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
