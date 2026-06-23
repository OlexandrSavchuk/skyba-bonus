import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner.freezed.dart';
part 'banner.g.dart';

@freezed
class PromoBanner with _$PromoBanner {
  const factory PromoBanner({
    required String id,
    String? title,
    String? imageUrl,
    String? linkUrl,
    String? linkType,
    @Default(0) int sortOrder,
  }) = _PromoBanner;

  factory PromoBanner.fromJson(Map<String, dynamic> json) =>
      _$PromoBannerFromJson(json);
}
