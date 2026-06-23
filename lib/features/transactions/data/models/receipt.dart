import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skyba_bonus/features/profile/data/models/loyalty_info.dart';
import 'package:skyba_bonus/features/transactions/data/models/receipt_product.dart';

part 'receipt.freezed.dart';
part 'receipt.g.dart';

@freezed
class Receipt with _$Receipt {
  const factory Receipt({
    required String id,
    required DateTime date,
    @Default(0) double cashSum,
    @Default(0) double cardSum,
    @Default(0) double discountSum,
    @Default(0) double bonusAddedSum,
    @Default(0) double bonusUsedSum,
    required double totalSum,
    @Default([]) List<ReceiptProduct> products,
    ShopBrief? shop,
  }) = _Receipt;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);
}
