// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_auth_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckAuthResponse {

 bool get authenticated;@JsonKey(name: 'user_id') String? get userId;
/// Create a copy of CheckAuthResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckAuthResponseCopyWith<CheckAuthResponse> get copyWith => _$CheckAuthResponseCopyWithImpl<CheckAuthResponse>(this as CheckAuthResponse, _$identity);

  /// Serializes this CheckAuthResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckAuthResponse&&(identical(other.authenticated, authenticated) || other.authenticated == authenticated)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authenticated,userId);

@override
String toString() {
  return 'CheckAuthResponse(authenticated: $authenticated, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $CheckAuthResponseCopyWith<$Res>  {
  factory $CheckAuthResponseCopyWith(CheckAuthResponse value, $Res Function(CheckAuthResponse) _then) = _$CheckAuthResponseCopyWithImpl;
@useResult
$Res call({
 bool authenticated,@JsonKey(name: 'user_id') String? userId
});




}
/// @nodoc
class _$CheckAuthResponseCopyWithImpl<$Res>
    implements $CheckAuthResponseCopyWith<$Res> {
  _$CheckAuthResponseCopyWithImpl(this._self, this._then);

  final CheckAuthResponse _self;
  final $Res Function(CheckAuthResponse) _then;

/// Create a copy of CheckAuthResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authenticated = null,Object? userId = freezed,}) {
  return _then(_self.copyWith(
authenticated: null == authenticated ? _self.authenticated : authenticated // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckAuthResponse].
extension CheckAuthResponsePatterns on CheckAuthResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckAuthResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckAuthResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckAuthResponse value)  $default,){
final _that = this;
switch (_that) {
case _CheckAuthResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckAuthResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CheckAuthResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool authenticated, @JsonKey(name: 'user_id')  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckAuthResponse() when $default != null:
return $default(_that.authenticated,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool authenticated, @JsonKey(name: 'user_id')  String? userId)  $default,) {final _that = this;
switch (_that) {
case _CheckAuthResponse():
return $default(_that.authenticated,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool authenticated, @JsonKey(name: 'user_id')  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _CheckAuthResponse() when $default != null:
return $default(_that.authenticated,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckAuthResponse implements CheckAuthResponse {
  const _CheckAuthResponse({required this.authenticated, @JsonKey(name: 'user_id') this.userId});
  factory _CheckAuthResponse.fromJson(Map<String, dynamic> json) => _$CheckAuthResponseFromJson(json);

@override final  bool authenticated;
@override@JsonKey(name: 'user_id') final  String? userId;

/// Create a copy of CheckAuthResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckAuthResponseCopyWith<_CheckAuthResponse> get copyWith => __$CheckAuthResponseCopyWithImpl<_CheckAuthResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckAuthResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckAuthResponse&&(identical(other.authenticated, authenticated) || other.authenticated == authenticated)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authenticated,userId);

@override
String toString() {
  return 'CheckAuthResponse(authenticated: $authenticated, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$CheckAuthResponseCopyWith<$Res> implements $CheckAuthResponseCopyWith<$Res> {
  factory _$CheckAuthResponseCopyWith(_CheckAuthResponse value, $Res Function(_CheckAuthResponse) _then) = __$CheckAuthResponseCopyWithImpl;
@override @useResult
$Res call({
 bool authenticated,@JsonKey(name: 'user_id') String? userId
});




}
/// @nodoc
class __$CheckAuthResponseCopyWithImpl<$Res>
    implements _$CheckAuthResponseCopyWith<$Res> {
  __$CheckAuthResponseCopyWithImpl(this._self, this._then);

  final _CheckAuthResponse _self;
  final $Res Function(_CheckAuthResponse) _then;

/// Create a copy of CheckAuthResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authenticated = null,Object? userId = freezed,}) {
  return _then(_CheckAuthResponse(
authenticated: null == authenticated ? _self.authenticated : authenticated // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
