import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String companyId,
    required String phone,
    required String password,
    @JsonKey(name: 'firstName') String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    String? birthday,
    String? sex,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
