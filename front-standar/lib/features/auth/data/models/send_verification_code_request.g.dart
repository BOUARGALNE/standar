// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verification_code_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendEmailVerificationRequest _$SendEmailVerificationRequestFromJson(
  Map<String, dynamic> json,
) => SendEmailVerificationRequest(email: json['email'] as String);

Map<String, dynamic> _$SendEmailVerificationRequestToJson(
  SendEmailVerificationRequest instance,
) => <String, dynamic>{'email': instance.email};

SendPhoneVerificationRequest _$SendPhoneVerificationRequestFromJson(
  Map<String, dynamic> json,
) => SendPhoneVerificationRequest(phone: json['phone'] as String);

Map<String, dynamic> _$SendPhoneVerificationRequestToJson(
  SendPhoneVerificationRequest instance,
) => <String, dynamic>{'phone': instance.phone};
