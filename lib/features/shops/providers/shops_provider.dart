import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/storage/secure_storage.dart';
import 'package:skyba_bonus/features/auth/data/models/company.dart';
import 'package:skyba_bonus/features/auth/providers/companies_provider.dart';
import 'package:skyba_bonus/features/shops/data/models/shop.dart';
import 'package:skyba_bonus/features/shops/data/shops_repository.dart';

/// The company (region) whose shops are currently displayed.
/// Null = all shops (fallback if companyId not known yet).
final selectedRegionProvider =
    StateNotifierProvider<SelectedRegionNotifier, String?>(
  (ref) => SelectedRegionNotifier(ref.watch(secureStorageProvider)),
);

class SelectedRegionNotifier extends StateNotifier<String?> {
  final SecureStorageService _storage;

  SelectedRegionNotifier(this._storage) : super(null) {
    _init();
  }

  Future<void> _init() async {
    state = await _storage.getCompanyId();
  }

  void select(String? companyId) {
    state = companyId;
  }
}

/// Shops filtered by selected region.
final shopsProvider =
    AsyncNotifierProvider<ShopsNotifier, List<Shop>>(ShopsNotifier.new);

class ShopsNotifier extends AsyncNotifier<List<Shop>> {
  @override
  Future<List<Shop>> build() async {
    final companyId = ref.watch(selectedRegionProvider);
    return _fetch(companyId);
  }

  Future<List<Shop>> _fetch(String? companyId) async {
    final repository = ref.read(shopsRepositoryProvider);
    return repository.getShops(companyId: companyId);
  }

  Future<void> refresh() async {
    final companyId = ref.read(selectedRegionProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetch(companyId));
  }
}

final shopDetailProvider =
    FutureProvider.family<Shop, String>((ref, id) async {
  final repository = ref.watch(shopsRepositoryProvider);
  return repository.getShop(id);
});
