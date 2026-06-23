import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/features/promotions/data/models/banner.dart';
import 'package:skyba_bonus/features/promotions/data/models/promotion.dart';
import 'package:skyba_bonus/features/promotions/data/promotions_repository.dart';

final promotionsProvider =
    AsyncNotifierProvider<PromotionsNotifier, List<Promotion>>(
  PromotionsNotifier.new,
);

class PromotionsNotifier extends AsyncNotifier<List<Promotion>> {
  @override
  Future<List<Promotion>> build() async {
    return _fetchPromotions();
  }

  Future<List<Promotion>> _fetchPromotions() async {
    final repository = ref.read(promotionsRepositoryProvider);
    return repository.getPromotions();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPromotions());
  }
}

final promotionDetailProvider =
    FutureProvider.family<Promotion, String>((ref, id) async {
  final repository = ref.watch(promotionsRepositoryProvider);
  return repository.getPromotion(id);
});

final bannersProvider = FutureProvider<List<PromoBanner>>((ref) async {
  final repository = ref.watch(promotionsRepositoryProvider);
  return repository.getBanners();
});
