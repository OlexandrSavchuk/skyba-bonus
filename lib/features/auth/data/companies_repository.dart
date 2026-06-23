import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/features/auth/data/models/company.dart';

class CompaniesRepository {
  final ApiClient _apiClient;

  CompaniesRepository(this._apiClient);

  Future<List<Company>> getCompanies() async {
    try {
      debugPrint('[CompaniesRepo] Fetching /companies...');
      final response = await _apiClient.get('/companies');
      debugPrint('[CompaniesRepo] Response status: ${response.statusCode}');
      debugPrint('[CompaniesRepo] Response data type: ${response.data.runtimeType}');
      debugPrint('[CompaniesRepo] Response data: ${response.data}');
      final list = (response.data as List)
          .map((json) => Company.fromJson(json as Map<String, dynamic>))
          .toList();
      debugPrint('[CompaniesRepo] Parsed ${list.length} companies');
      return list;
    } catch (e, st) {
      debugPrint('[CompaniesRepo] ERROR: $e');
      debugPrint('[CompaniesRepo] Stack: $st');
      rethrow;
    }
  }
}
