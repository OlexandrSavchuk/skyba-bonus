import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_info.freezed.dart';
part 'loyalty_info.g.dart';

@freezed
class LoyaltyInfo with _$LoyaltyInfo {
  const factory LoyaltyInfo({
    required String id,
    required ShopBrief shop,
    @Default(0) double bonus,
    @Default(0) double personalDiscount,
  }) = _LoyaltyInfo;

  factory LoyaltyInfo.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyInfoFromJson(json);
}

@freezed
class ShopBrief with _$ShopBrief {
  const factory ShopBrief({
    required String id,
    required String name,
    String? address,
  }) = _ShopBrief;

  factory ShopBrief.fromJson(Map<String, dynamic> json) =>
      _$ShopBriefFromJson(json);
}
