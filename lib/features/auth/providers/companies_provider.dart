import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/network/api_client.dart';
import 'package:skyba_bonus/features/auth/data/companies_repository.dart';
import 'package:skyba_bonus/features/auth/data/models/company.dart';

final companiesRepositoryProvider = Provider<CompaniesRepository>((ref) {
  return CompaniesRepository(ref.watch(apiClientProvider));
});

final companiesProvider = FutureProvider<List<Company>>((ref) async {
  final repository = ref.watch(companiesRepositoryProvider);
  return repository.getCompanies();
});
