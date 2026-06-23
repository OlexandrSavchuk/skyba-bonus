// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BonusBalanceImpl _$$BonusBalanceImplFromJson(Map<String, dynamic> json) =>
    _$BonusBalanceImpl(
      totalBonus: (json['totalBonus'] as num?)?.toDouble() ?? 0,
      loyaltyByShop: (json['loyaltyByShop'] as List<dynamic>?)
              ?.map((e) => LoyaltyInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BonusBalanceImplToJson(_$BonusBalanceImpl instance) =>
    <String, dynamic>{
      'totalBonus': instance.totalBonus,
      'loyaltyByShop': instance.loyaltyByShop,
    };
