// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterResponseData _$RegisterResponseDataFromJson(
  Map<String, dynamic> json,
) => _RegisterResponseData(
  userId: json['user_id'] as String,
  profilePicture: json['profile_photo'] as String?,
  token: json['token'] as String,
  refreshToken: json['refresh_token'] as String,
);

Map<String, dynamic> _$RegisterResponseDataToJson(
  _RegisterResponseData instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'profile_photo': instance.profilePicture,
  'token': instance.token,
  'refresh_token': instance.refreshToken,
};
