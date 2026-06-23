// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReceiptProductImpl _$$ReceiptProductImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptProductImpl(
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      sum: (json['sum'] as num).toDouble(),
      discountSum: (json['discountSum'] as num?)?.toDouble() ?? 0,
      name: json['name'] as String,
      measurement: json['measurement'] as String?,
    );

Map<String, dynamic> _$$ReceiptProductImplToJson(
        _$ReceiptProductImpl instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'price': instance.price,
      'sum': instance.sum,
      'discountSum': instance.discountSum,
      'name': instance.name,
      'measurement': instance.measurement,
    };
