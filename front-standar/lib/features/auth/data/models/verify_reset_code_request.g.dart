// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_reset_code_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyResetCodeRequest _$VerifyResetCodeRequestFromJson(
  Map<String, dynamic> json,
) => _VerifyResetCodeRequest(
  email: json['email'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$VerifyResetCodeRequestToJson(
  _VerifyResetCodeRequest instance,
) => <String, dynamic>{'email': instance.email, 'code': instance.code};
