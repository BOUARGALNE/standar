import 'package:json_annotation/json_annotation.dart';

part 'verify_code_request.g.dart';

/// Request model for verifying email code
@JsonSerializable()
class VerifyEmailCodeRequest {
  const VerifyEmailCodeRequest({required this.email, required this.code});

  final String email;
  
  @JsonKey(name: 'otp_code')
  final String code;

  factory VerifyEmailCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailCodeRequestToJson(this);
}

/// Request model for verifying phone code
@JsonSerializable()
class VerifyPhoneCodeRequest {
  const VerifyPhoneCodeRequest({required this.phone, required this.code});

  final String phone;
  final String code;

  factory VerifyPhoneCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhoneCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPhoneCodeRequestToJson(this);
}
