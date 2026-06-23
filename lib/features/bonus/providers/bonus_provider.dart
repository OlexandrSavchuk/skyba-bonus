import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/features/bonus/data/models/bonus_balance.dart';
import 'package:skyba_bonus/features/profile/providers/profile_provider.dart';

final bonusBalanceProvider = Provider<BonusBalance>((ref) {
  final profileAsync = ref.watch(profileProvider);

  return profileAsync.when(
    data: (profile) {
      if (profile == null) return const BonusBalance();
      final totalBonus = profile.loyalty.fold<double>(
        0,
        (sum, l) => sum + l.bonus,
      );
      return BonusBalance(
        totalBonus: totalBonus,
        loyaltyByShop: profile.loyalty,
      );
    },
    loading: () => const BonusBalance(),
    error: (_, __) => const BonusBalance(),
  );
});

final barcodeProvider = Provider<String>((ref) {
  final profileAsync = ref.watch(profileProvider);
  return profileAsync.when(
    data: (profile) => profile?.barcode ?? '',
    loading: () => '',
    error: (_, __) => '',
  );
});
