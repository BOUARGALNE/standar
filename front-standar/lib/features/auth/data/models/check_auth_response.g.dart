// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckAuthResponse _$CheckAuthResponseFromJson(Map<String, dynamic> json) =>
    _CheckAuthResponse(
      authenticated: json['authenticated'] as bool,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$CheckAuthResponseToJson(_CheckAuthResponse instance) =>
    <String, dynamic>{
      'authenticated': instance.authenticated,
      'user_id': instance.userId,
    };
