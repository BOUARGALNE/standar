import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';



/// Data object containing user and token from register response
@freezed
abstract class RegisterResponseData with _$RegisterResponseData {
  const factory RegisterResponseData({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'profile_photo') String? profilePicture,
    @JsonKey(name: 'token') required String token,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _RegisterResponseData;

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDataFromJson(json);
}
