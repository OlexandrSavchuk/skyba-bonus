import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    @Default(0) double price,
    @Default(0) double amount,
    @Default(false) bool weightProduct,
    String? barcode,
    String? coverPath,
    String? subcategory,
    @Default(0) double shopQuantity,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
