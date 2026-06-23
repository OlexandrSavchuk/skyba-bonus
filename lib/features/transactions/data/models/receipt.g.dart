// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReceiptImpl _$$ReceiptImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      cashSum: (json['cashSum'] as num?)?.toDouble() ?? 0,
      cardSum: (json['cardSum'] as num?)?.toDouble() ?? 0,
      discountSum: (json['discountSum'] as num?)?.toDouble() ?? 0,
      bonusAddedSum: (json['bonusAddedSum'] as num?)?.toDouble() ?? 0,
      bonusUsedSum: (json['bonusUsedSum'] as num?)?.toDouble() ?? 0,
      totalSum: (json['totalSum'] as num).toDouble(),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ReceiptProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      shop: json['shop'] == null
          ? null
          : ShopBrief.fromJson(json['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReceiptImplToJson(_$ReceiptImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'cashSum': instance.cashSum,
      'cardSum': instance.cardSum,
      'discountSum': instance.discountSum,
      'bonusAddedSum': instance.bonusAddedSum,
      'bonusUsedSum': instance.bonusUsedSum,
      'totalSum': instance.totalSum,
      'products': instance.products,
      'shop': instance.shop,
    };
