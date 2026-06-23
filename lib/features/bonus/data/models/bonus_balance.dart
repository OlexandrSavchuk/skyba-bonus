import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skyba_bonus/features/profile/data/models/loyalty_info.dart';

part 'bonus_balance.freezed.dart';
part 'bonus_balance.g.dart';

@freezed
class BonusBalance with _$BonusBalance {
  const factory BonusBalance({
    @Default(0) double totalBonus,
    @Default([]) List<LoyaltyInfo> loyaltyByShop,
  }) = _BonusBalance;

  factory BonusBalance.fromJson(Map<String, dynamic> json) =>
      _$BonusBalanceFromJson(json);
}
