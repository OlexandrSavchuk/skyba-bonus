// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoyaltyInfoImpl _$$LoyaltyInfoImplFromJson(Map<String, dynamic> json) =>
    _$LoyaltyInfoImpl(
      id: json['id'] as String,
      shop: ShopBrief.fromJson(json['shop'] as Map<String, dynamic>),
      bonus: (json['bonus'] as num?)?.toDouble() ?? 0,
      personalDiscount: (json['personalDiscount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$LoyaltyInfoImplToJson(_$LoyaltyInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop': instance.shop,
      'bonus': instance.bonus,
      'personalDiscount': instance.personalDiscount,
    };

_$ShopBriefImpl _$$ShopBriefImplFromJson(Map<String, dynamic> json) =>
    _$ShopBriefImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$ShopBriefImplToJson(_$ShopBriefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
    };
