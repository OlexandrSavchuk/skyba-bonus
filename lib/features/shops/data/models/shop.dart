import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  const factory Shop({
    required String id,
    required String name,
    String? address,
    String? city,
    String? phone,
    String? workHours,
    String? fop,
    double? latitude,
    double? longitude,
    String? companyId,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}
