import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/config/app_config.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/catalog/data/models/category.dart';
import 'package:skyba_bonus/features/catalog/data/models/product.dart';
import 'package:skyba_bonus/features/catalog/data/models/subcategory.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CatalogRepository(apiClient: apiClient);
});

class CatalogRepository {
  final ApiClient _apiClient;

  CatalogRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<Category>> getCategories(String shopId) async {
    try {
      final response = await _apiClient.get(
        '/shops/$shopId/categories',
      );
      final List<dynamic> data = response.data is List
          ? response.data as List<dynamic>
          : (response.data['items'] as List<dynamic>?) ?? [];
      return data
          .map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити категорії',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<List<Subcategory>> getSubcategories(
    String shopId, {
    String? categoryId,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (categoryId != null) queryParams['categoryId'] = categoryId;

      final response = await _apiClient.get(
        '/shops/$shopId/subcategories',
        queryParameters: queryParams,
      );
      final List<dynamic> data = response.data is List
          ? response.data as List<dynamic>
          : (response.data['items'] as List<dynamic>?) ?? [];
      return data
          .map((item) => Subcategory.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити підкатегорії',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<List<Product>> getProducts(
    String shopId, {
    String? categoryId,
    String? subcategoryId,
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (subcategoryId != null) queryParams['subcategoryId'] = subcategoryId;
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;

      final response = await _apiClient.get(
        '/shops/$shopId/products',
        queryParameters: queryParams,
      );
      final List<dynamic> data = response.data is List
          ? response.data as List<dynamic>
          : (response.data['items'] as List<dynamic>?) ?? [];
      return data
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити товари',
        statusCode: e.response?.statusCode,
      );
    }
  }

  String getProductCoverUrl(String productId, String coverPath) {
    return '${AppConfig.baseUrl}/products/$productId/cover/$coverPath';
  }
}
