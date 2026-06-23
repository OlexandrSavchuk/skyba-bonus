// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      weightProduct: json['weightProduct'] as bool? ?? false,
      barcode: json['barcode'] as String?,
      coverPath: json['coverPath'] as String?,
      subcategory: json['subcategory'] as String?,
      shopQuantity: (json['shopQuantity'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'weightProduct': instance.weightProduct,
      'barcode': instance.barcode,
      'coverPath': instance.coverPath,
      'subcategory': instance.subcategory,
      'shopQuantity': instance.shopQuantity,
    };
