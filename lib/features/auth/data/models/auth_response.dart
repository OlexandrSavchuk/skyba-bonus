import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    AuthClient? client,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
class AuthClient with _$AuthClient {
  const factory AuthClient({
    required String id,
    String? phone,
    String? firstName,
    String? lastName,
  }) = _AuthClient;

  factory AuthClient.fromJson(Map<String, dynamic> json) =>
      _$AuthClientFromJson(json);
}
