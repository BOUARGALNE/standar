// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterResponseData {

@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'profile_photo') String? get profilePicture;@JsonKey(name: 'token') String get token;@JsonKey(name: 'refresh_token') String get refreshToken;
/// Create a copy of RegisterResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterResponseDataCopyWith<RegisterResponseData> get copyWith => _$RegisterResponseDataCopyWithImpl<RegisterResponseData>(this as RegisterResponseData, _$identity);

  /// Serializes this RegisterResponseData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterResponseData&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.token, token) || other.token == token)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,profilePicture,token,refreshToken);

@override
String toString() {
  return 'RegisterResponseData(userId: $userId, profilePicture: $profilePicture, token: $token, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $RegisterResponseDataCopyWith<$Res>  {
  factory $RegisterResponseDataCopyWith(RegisterResponseData value, $Res Function(RegisterResponseData) _then) = _$RegisterResponseDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'profile_photo') String? profilePicture,@JsonKey(name: 'token') String token,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class _$RegisterResponseDataCopyWithImpl<$Res>
    implements $RegisterResponseDataCopyWith<$Res> {
  _$RegisterResponseDataCopyWithImpl(this._self, this._then);

  final RegisterResponseData _self;
  final $Res Function(RegisterResponseData) _then;

/// Create a copy of RegisterResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? profilePicture = freezed,Object? token = null,Object? refreshToken = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterResponseData].
extension RegisterResponseDataPatterns on RegisterResponseData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterResponseData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterResponseData value)  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'profile_photo')  String? profilePicture, @JsonKey(name: 'token')  String token, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterResponseData() when $default != null:
return $default(_that.userId,_that.profilePicture,_that.token,_that.refreshToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'profile_photo')  String? profilePicture, @JsonKey(name: 'token')  String token, @JsonKey(name: 'refresh_token')  String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _RegisterResponseData():
return $default(_that.userId,_that.profilePicture,_that.token,_that.refreshToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'profile_photo')  String? profilePicture, @JsonKey(name: 'token')  String token, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _RegisterResponseData() when $default != null:
return $default(_that.userId,_that.profilePicture,_that.token,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterResponseData implements RegisterResponseData {
  const _RegisterResponseData({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'profile_photo') this.profilePicture, @JsonKey(name: 'token') required this.token, @JsonKey(name: 'refresh_token') required this.refreshToken});
  factory _RegisterResponseData.fromJson(Map<String, dynamic> json) => _$RegisterResponseDataFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'profile_photo') final  String? profilePicture;
@override@JsonKey(name: 'token') final  String token;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;

/// Create a copy of RegisterResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterResponseDataCopyWith<_RegisterResponseData> get copyWith => __$RegisterResponseDataCopyWithImpl<_RegisterResponseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterResponseDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterResponseData&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.token, token) || other.token == token)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,profilePicture,token,refreshToken);

@override
String toString() {
  return 'RegisterResponseData(userId: $userId, profilePicture: $profilePicture, token: $token, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$RegisterResponseDataCopyWith<$Res> implements $RegisterResponseDataCopyWith<$Res> {
  factory _$RegisterResponseDataCopyWith(_RegisterResponseData value, $Res Function(_RegisterResponseData) _then) = __$RegisterResponseDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'profile_photo') String? profilePicture,@JsonKey(name: 'token') String token,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class __$RegisterResponseDataCopyWithImpl<$Res>
    implements _$RegisterResponseDataCopyWith<$Res> {
  __$RegisterResponseDataCopyWithImpl(this._self, this._then);

  final _RegisterResponseData _self;
  final $Res Function(_RegisterResponseData) _then;

/// Create a copy of RegisterResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? profilePicture = freezed,Object? token = null,Object? refreshToken = null,}) {
  return _then(_RegisterResponseData(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
