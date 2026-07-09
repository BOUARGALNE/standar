// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    _LoginResponseData(
      userId: json['user_id'] as String,
      profilePicture: json['profile_photo'] as String?,
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$LoginResponseDataToJson(_LoginResponseData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'profile_photo': instance.profilePicture,
      'token': instance.token,
      'refresh_token': instance.refreshToken,
    };
