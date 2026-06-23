import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_product.freezed.dart';
part 'receipt_product.g.dart';

@freezed
class ReceiptProduct with _$ReceiptProduct {
  const factory ReceiptProduct({
    required double quantity,
    required double price,
    required double sum,
    @Default(0) double discountSum,
    required String name,
    String? measurement,
  }) = _ReceiptProduct;

  factory ReceiptProduct.fromJson(Map<String, dynamic> json) =>
      _$ReceiptProductFromJson(json);
}
