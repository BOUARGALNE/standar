import 'package:json_annotation/json_annotation.dart';

part 'send_verification_code_request.g.dart';

/// Request model for sending email verification code
@JsonSerializable()
class SendEmailVerificationRequest {
  const SendEmailVerificationRequest({required this.email});

  final String email;

  factory SendEmailVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendEmailVerificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendEmailVerificationRequestToJson(this);
}

/// Request model for sending phone verification code
@JsonSerializable()
class SendPhoneVerificationRequest {
  const SendPhoneVerificationRequest({required this.phone});

  final String phone;

  factory SendPhoneVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendPhoneVerificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendPhoneVerificationRequestToJson(this);
}
