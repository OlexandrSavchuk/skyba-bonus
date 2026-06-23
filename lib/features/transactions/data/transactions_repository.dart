import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/core/network/api_exceptions.dart';
import 'package:skyba_bonus/features/transactions/data/models/receipt.dart';

final transactionsRepositoryProvider =
    Provider<TransactionsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TransactionsRepository(apiClient: apiClient);
});

class TransactionsRepository {
  final ApiClient _apiClient;

  TransactionsRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<Receipt>> getTransactions({
    required DateTime fromDate,
    required DateTime toDate,
    String? shopId,
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'fromDate': fromDate.toIso8601String(),
        'toDate': toDate.toIso8601String(),
      };
      if (shopId != null) queryParams['shopId'] = shopId;
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;

      final response = await _apiClient.get(
        '/bonus/transactions',
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data is List
          ? response.data as List<dynamic>
          : (response.data['data'] as List<dynamic>?)
              ?? (response.data['items'] as List<dynamic>?)
              ?? [];

      return data
          .map((item) => Receipt.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити транзакції',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Receipt> getTransaction(String id) async {
    try {
      final response = await _apiClient.get('/bonus/transactions/$id');
      return Receipt.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: 'Не вдалося завантажити деталі чеку',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
