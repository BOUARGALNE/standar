// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailCodeRequest _$VerifyEmailCodeRequestFromJson(
  Map<String, dynamic> json,
) => VerifyEmailCodeRequest(
  email: json['email'] as String,
  code: json['otp_code'] as String,
);

Map<String, dynamic> _$VerifyEmailCodeRequestToJson(
  VerifyEmailCodeRequest instance,
) => <String, dynamic>{'email': instance.email, 'otp_code': instance.code};

VerifyPhoneCodeRequest _$VerifyPhoneCodeRequestFromJson(
  Map<String, dynamic> json,
) => VerifyPhoneCodeRequest(
  phone: json['phone'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$VerifyPhoneCodeRequestToJson(
  VerifyPhoneCodeRequest instance,
) => <String, dynamic>{'phone': instance.phone, 'code': instance.code};
