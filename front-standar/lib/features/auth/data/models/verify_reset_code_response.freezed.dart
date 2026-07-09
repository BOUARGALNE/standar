// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_reset_code_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyResetCodeResponseData {

@JsonKey(name: 'reset_token') String get resetToken;
/// Create a copy of VerifyResetCodeResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyResetCodeResponseDataCopyWith<VerifyResetCodeResponseData> get copyWith => _$VerifyResetCodeResponseDataCopyWithImpl<VerifyResetCodeResponseData>(this as VerifyResetCodeResponseData, _$identity);

  /// Serializes this VerifyResetCodeResponseData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyResetCodeResponseData&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resetToken);

@override
String toString() {
  return 'VerifyResetCodeResponseData(resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $VerifyResetCodeResponseDataCopyWith<$Res>  {
  factory $VerifyResetCodeResponseDataCopyWith(VerifyResetCodeResponseData value, $Res Function(VerifyResetCodeResponseData) _then) = _$VerifyResetCodeResponseDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'reset_token') String resetToken
});




}
/// @nodoc
class _$VerifyResetCodeResponseDataCopyWithImpl<$Res>
    implements $VerifyResetCodeResponseDataCopyWith<$Res> {
  _$VerifyResetCodeResponseDataCopyWithImpl(this._self, this._then);

  final VerifyResetCodeResponseData _self;
  final $Res Function(VerifyResetCodeResponseData) _then;

/// Create a copy of VerifyResetCodeResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resetToken = null,}) {
  return _then(_self.copyWith(
resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyResetCodeResponseData].
extension VerifyResetCodeResponseDataPatterns on VerifyResetCodeResponseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyResetCodeResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyResetCodeResponseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyResetCodeResponseData value)  $default,){
final _that = this;
switch (_that) {
case _VerifyResetCodeResponseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyResetCodeResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyResetCodeResponseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'reset_token')  String resetToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyResetCodeResponseData() when $default != null:
return $default(_that.resetToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'reset_token')  String resetToken)  $default,) {final _that = this;
switch (_that) {
case _VerifyResetCodeResponseData():
return $default(_that.resetToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'reset_token')  String resetToken)?  $default,) {final _that = this;
switch (_that) {
case _VerifyResetCodeResponseData() when $default != null:
return $default(_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyResetCodeResponseData implements VerifyResetCodeResponseData {
  const _VerifyResetCodeResponseData({@JsonKey(name: 'reset_token') required this.resetToken});
  factory _VerifyResetCodeResponseData.fromJson(Map<String, dynamic> json) => _$VerifyResetCodeResponseDataFromJson(json);

@override@JsonKey(name: 'reset_token') final  String resetToken;

/// Create a copy of VerifyResetCodeResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyResetCodeResponseDataCopyWith<_VerifyResetCodeResponseData> get copyWith => __$VerifyResetCodeResponseDataCopyWithImpl<_VerifyResetCodeResponseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyResetCodeResponseDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyResetCodeResponseData&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resetToken);

@override
String toString() {
  return 'VerifyResetCodeResponseData(resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class _$VerifyResetCodeResponseDataCopyWith<$Res> implements $VerifyResetCodeResponseDataCopyWith<$Res> {
  factory _$VerifyResetCodeResponseDataCopyWith(_VerifyResetCodeResponseData value, $Res Function(_VerifyResetCodeResponseData) _then) = __$VerifyResetCodeResponseDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'reset_token') String resetToken
});




}
/// @nodoc
class __$VerifyResetCodeResponseDataCopyWithImpl<$Res>
    implements _$VerifyResetCodeResponseDataCopyWith<$Res> {
  __$VerifyResetCodeResponseDataCopyWithImpl(this._self, this._then);

  final _VerifyResetCodeResponseData _self;
  final $Res Function(_VerifyResetCodeResponseData) _then;

/// Create a copy of VerifyResetCodeResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resetToken = null,}) {
  return _then(_VerifyResetCodeResponseData(
resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
