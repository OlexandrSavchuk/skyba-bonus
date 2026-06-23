import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skyba_bonus/features/profile/data/models/loyalty_info.dart';

part 'client_profile.freezed.dart';
part 'client_profile.g.dart';

@freezed
class ClientProfile with _$ClientProfile {
  const factory ClientProfile({
    required String id,
    String? mobilePhone,
    String? email,
    String? name,
    String? lastName,
    String? middleName,
    @Default(false) bool locked,
    String? birthDay,
    String? barcode,
    @Default([]) List<LoyaltyInfo> loyalty,
  }) = _ClientProfile;

  factory ClientProfile.fromJson(Map<String, dynamic> json) =>
      _$ClientProfileFromJson(json);
}
