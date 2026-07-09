import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

/// Data object containing user and token from login response
@freezed
abstract class LoginResponseData with _$LoginResponseData {
  const factory LoginResponseData({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'profile_photo') String? profilePicture,
    @JsonKey(name: 'token') required String token,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _LoginResponseData;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);
}
