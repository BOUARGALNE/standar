// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordEvent()';
}


}

/// @nodoc
class $ForgotPasswordEventCopyWith<$Res>  {
$ForgotPasswordEventCopyWith(ForgotPasswordEvent _, $Res Function(ForgotPasswordEvent) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordEvent].
extension ForgotPasswordEventPatterns on ForgotPasswordEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ForgotPasswordEmailSendRequested value)?  emailSendRequested,TResult Function( ForgotPasswordCodeVerifyRequested value)?  codeVerifyRequested,TResult Function( ForgotPasswordPasswordResetRequested value)?  passwordResetRequested,TResult Function( ForgotPasswordResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ForgotPasswordEmailSendRequested() when emailSendRequested != null:
return emailSendRequested(_that);case ForgotPasswordCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that);case ForgotPasswordPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case ForgotPasswordResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ForgotPasswordEmailSendRequested value)  emailSendRequested,required TResult Function( ForgotPasswordCodeVerifyRequested value)  codeVerifyRequested,required TResult Function( ForgotPasswordPasswordResetRequested value)  passwordResetRequested,required TResult Function( ForgotPasswordResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case ForgotPasswordEmailSendRequested():
return emailSendRequested(_that);case ForgotPasswordCodeVerifyRequested():
return codeVerifyRequested(_that);case ForgotPasswordPasswordResetRequested():
return passwordResetRequested(_that);case ForgotPasswordResetRequested():
return resetRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ForgotPasswordEmailSendRequested value)?  emailSendRequested,TResult? Function( ForgotPasswordCodeVerifyRequested value)?  codeVerifyRequested,TResult? Function( ForgotPasswordPasswordResetRequested value)?  passwordResetRequested,TResult? Function( ForgotPasswordResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case ForgotPasswordEmailSendRequested() when emailSendRequested != null:
return emailSendRequested(_that);case ForgotPasswordCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that);case ForgotPasswordPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case ForgotPasswordResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email)?  emailSendRequested,TResult Function( String email,  String code)?  codeVerifyRequested,TResult Function( String email,  String otpCode,  String newPassword,  String confirmPassword)?  passwordResetRequested,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ForgotPasswordEmailSendRequested() when emailSendRequested != null:
return emailSendRequested(_that.email);case ForgotPasswordCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that.email,_that.code);case ForgotPasswordPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email,_that.otpCode,_that.newPassword,_that.confirmPassword);case ForgotPasswordResetRequested() when resetRequested != null:
return resetRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email)  emailSendRequested,required TResult Function( String email,  String code)  codeVerifyRequested,required TResult Function( String email,  String otpCode,  String newPassword,  String confirmPassword)  passwordResetRequested,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case ForgotPasswordEmailSendRequested():
return emailSendRequested(_that.email);case ForgotPasswordCodeVerifyRequested():
return codeVerifyRequested(_that.email,_that.code);case ForgotPasswordPasswordResetRequested():
return passwordResetRequested(_that.email,_that.otpCode,_that.newPassword,_that.confirmPassword);case ForgotPasswordResetRequested():
return resetRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email)?  emailSendRequested,TResult? Function( String email,  String code)?  codeVerifyRequested,TResult? Function( String email,  String otpCode,  String newPassword,  String confirmPassword)?  passwordResetRequested,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case ForgotPasswordEmailSendRequested() when emailSendRequested != null:
return emailSendRequested(_that.email);case ForgotPasswordCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that.email,_that.code);case ForgotPasswordPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email,_that.otpCode,_that.newPassword,_that.confirmPassword);case ForgotPasswordResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class ForgotPasswordEmailSendRequested implements ForgotPasswordEvent {
  const ForgotPasswordEmailSendRequested({required this.email});
  

 final  String email;

/// Create a copy of ForgotPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordEmailSendRequestedCopyWith<ForgotPasswordEmailSendRequested> get copyWith => _$ForgotPasswordEmailSendRequestedCopyWithImpl<ForgotPasswordEmailSendRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordEmailSendRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ForgotPasswordEvent.emailSendRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordEmailSendRequestedCopyWith<$Res> implements $ForgotPasswordEventCopyWith<$Res> {
  factory $ForgotPasswordEmailSendRequestedCopyWith(ForgotPasswordEmailSendRequested value, $Res Function(ForgotPasswordEmailSendRequested) _then) = _$ForgotPasswordEmailSendRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ForgotPasswordEmailSendRequestedCopyWithImpl<$Res>
    implements $ForgotPasswordEmailSendRequestedCopyWith<$Res> {
  _$ForgotPasswordEmailSendRequestedCopyWithImpl(this._self, this._then);

  final ForgotPasswordEmailSendRequested _self;
  final $Res Function(ForgotPasswordEmailSendRequested) _then;

/// Create a copy of ForgotPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(ForgotPasswordEmailSendRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordCodeVerifyRequested implements ForgotPasswordEvent {
  const ForgotPasswordCodeVerifyRequested({required this.email, required this.code});
  

 final  String email;
 final  String code;

/// Create a copy of ForgotPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordCodeVerifyRequestedCopyWith<ForgotPasswordCodeVerifyRequested> get copyWith => _$ForgotPasswordCodeVerifyRequestedCopyWithImpl<ForgotPasswordCodeVerifyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordCodeVerifyRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,email,code);

@override
String toString() {
  return 'ForgotPasswordEvent.codeVerifyRequested(email: $email, code: $code)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordCodeVerifyRequestedCopyWith<$Res> implements $ForgotPasswordEventCopyWith<$Res> {
  factory $ForgotPasswordCodeVerifyRequestedCopyWith(ForgotPasswordCodeVerifyRequested value, $Res Function(ForgotPasswordCodeVerifyRequested) _then) = _$ForgotPasswordCodeVerifyRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String code
});




}
/// @nodoc
class _$ForgotPasswordCodeVerifyRequestedCopyWithImpl<$Res>
    implements $ForgotPasswordCodeVerifyRequestedCopyWith<$Res> {
  _$ForgotPasswordCodeVerifyRequestedCopyWithImpl(this._self, this._then);

  final ForgotPasswordCodeVerifyRequested _self;
  final $Res Function(ForgotPasswordCodeVerifyRequested) _then;

/// Create a copy of ForgotPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? code = null,}) {
  return _then(ForgotPasswordCodeVerifyRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordPasswordResetRequested implements ForgotPasswordEvent {
  const ForgotPasswordPasswordResetRequested({required this.email, required this.otpCode, required this.newPassword, required this.confirmPassword});
  

 final  String email;
 final  String otpCode;
 final  String newPassword;
 final  String confirmPassword;

/// Create a copy of ForgotPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordPasswordResetRequestedCopyWith<ForgotPasswordPasswordResetRequested> get copyWith => _$ForgotPasswordPasswordResetRequestedCopyWithImpl<ForgotPasswordPasswordResetRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordPasswordResetRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,email,otpCode,newPassword,confirmPassword);

@override
String toString() {
  return 'ForgotPasswordEvent.passwordResetRequested(email: $email, otpCode: $otpCode, newPassword: $newPassword, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordPasswordResetRequestedCopyWith<$Res> implements $ForgotPasswordEventCopyWith<$Res> {
  factory $ForgotPasswordPasswordResetRequestedCopyWith(ForgotPasswordPasswordResetRequested value, $Res Function(ForgotPasswordPasswordResetRequested) _then) = _$ForgotPasswordPasswordResetRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String otpCode, String newPassword, String confirmPassword
});




}
/// @nodoc
class _$ForgotPasswordPasswordResetRequestedCopyWithImpl<$Res>
    implements $ForgotPasswordPasswordResetRequestedCopyWith<$Res> {
  _$ForgotPasswordPasswordResetRequestedCopyWithImpl(this._self, this._then);

  final ForgotPasswordPasswordResetRequested _self;
  final $Res Function(ForgotPasswordPasswordResetRequested) _then;

/// Create a copy of ForgotPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? otpCode = null,Object? newPassword = null,Object? confirmPassword = null,}) {
  return _then(ForgotPasswordPasswordResetRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordResetRequested implements ForgotPasswordEvent {
  const ForgotPasswordResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordEvent.resetRequested()';
}


}




/// @nodoc
mixin _$ForgotPasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState _, $Res Function(ForgotPasswordState) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ForgotPasswordInitial value)?  initial,TResult Function( ForgotPasswordLoading value)?  loading,TResult Function( ForgotPasswordEmailSent value)?  emailSent,TResult Function( ForgotPasswordCodeVerified value)?  codeVerified,TResult Function( ForgotPasswordSuccess value)?  success,TResult Function( ForgotPasswordFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial(_that);case ForgotPasswordLoading() when loading != null:
return loading(_that);case ForgotPasswordEmailSent() when emailSent != null:
return emailSent(_that);case ForgotPasswordCodeVerified() when codeVerified != null:
return codeVerified(_that);case ForgotPasswordSuccess() when success != null:
return success(_that);case ForgotPasswordFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ForgotPasswordInitial value)  initial,required TResult Function( ForgotPasswordLoading value)  loading,required TResult Function( ForgotPasswordEmailSent value)  emailSent,required TResult Function( ForgotPasswordCodeVerified value)  codeVerified,required TResult Function( ForgotPasswordSuccess value)  success,required TResult Function( ForgotPasswordFailure value)  failure,}){
final _that = this;
switch (_that) {
case ForgotPasswordInitial():
return initial(_that);case ForgotPasswordLoading():
return loading(_that);case ForgotPasswordEmailSent():
return emailSent(_that);case ForgotPasswordCodeVerified():
return codeVerified(_that);case ForgotPasswordSuccess():
return success(_that);case ForgotPasswordFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ForgotPasswordInitial value)?  initial,TResult? Function( ForgotPasswordLoading value)?  loading,TResult? Function( ForgotPasswordEmailSent value)?  emailSent,TResult? Function( ForgotPasswordCodeVerified value)?  codeVerified,TResult? Function( ForgotPasswordSuccess value)?  success,TResult? Function( ForgotPasswordFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial(_that);case ForgotPasswordLoading() when loading != null:
return loading(_that);case ForgotPasswordEmailSent() when emailSent != null:
return emailSent(_that);case ForgotPasswordCodeVerified() when codeVerified != null:
return codeVerified(_that);case ForgotPasswordSuccess() when success != null:
return success(_that);case ForgotPasswordFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( ForgotPasswordLoadingAction action,  String? message)?  loading,TResult Function( String message)?  emailSent,TResult Function( String resetToken)?  codeVerified,TResult Function()?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial();case ForgotPasswordLoading() when loading != null:
return loading(_that.action,_that.message);case ForgotPasswordEmailSent() when emailSent != null:
return emailSent(_that.message);case ForgotPasswordCodeVerified() when codeVerified != null:
return codeVerified(_that.resetToken);case ForgotPasswordSuccess() when success != null:
return success();case ForgotPasswordFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( ForgotPasswordLoadingAction action,  String? message)  loading,required TResult Function( String message)  emailSent,required TResult Function( String resetToken)  codeVerified,required TResult Function()  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ForgotPasswordInitial():
return initial();case ForgotPasswordLoading():
return loading(_that.action,_that.message);case ForgotPasswordEmailSent():
return emailSent(_that.message);case ForgotPasswordCodeVerified():
return codeVerified(_that.resetToken);case ForgotPasswordSuccess():
return success();case ForgotPasswordFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( ForgotPasswordLoadingAction action,  String? message)?  loading,TResult? Function( String message)?  emailSent,TResult? Function( String resetToken)?  codeVerified,TResult? Function()?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial();case ForgotPasswordLoading() when loading != null:
return loading(_that.action,_that.message);case ForgotPasswordEmailSent() when emailSent != null:
return emailSent(_that.message);case ForgotPasswordCodeVerified() when codeVerified != null:
return codeVerified(_that.resetToken);case ForgotPasswordSuccess() when success != null:
return success();case ForgotPasswordFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ForgotPasswordInitial implements ForgotPasswordState {
  const ForgotPasswordInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.initial()';
}


}




/// @nodoc


class ForgotPasswordLoading implements ForgotPasswordState {
  const ForgotPasswordLoading({required this.action, this.message});
  

 final  ForgotPasswordLoadingAction action;
 final  String? message;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordLoadingCopyWith<ForgotPasswordLoading> get copyWith => _$ForgotPasswordLoadingCopyWithImpl<ForgotPasswordLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordLoading&&(identical(other.action, action) || other.action == action)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,message);

@override
String toString() {
  return 'ForgotPasswordState.loading(action: $action, message: $message)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordLoadingCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordLoadingCopyWith(ForgotPasswordLoading value, $Res Function(ForgotPasswordLoading) _then) = _$ForgotPasswordLoadingCopyWithImpl;
@useResult
$Res call({
 ForgotPasswordLoadingAction action, String? message
});




}
/// @nodoc
class _$ForgotPasswordLoadingCopyWithImpl<$Res>
    implements $ForgotPasswordLoadingCopyWith<$Res> {
  _$ForgotPasswordLoadingCopyWithImpl(this._self, this._then);

  final ForgotPasswordLoading _self;
  final $Res Function(ForgotPasswordLoading) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,Object? message = freezed,}) {
  return _then(ForgotPasswordLoading(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ForgotPasswordLoadingAction,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ForgotPasswordEmailSent implements ForgotPasswordState {
  const ForgotPasswordEmailSent({required this.message});
  

 final  String message;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordEmailSentCopyWith<ForgotPasswordEmailSent> get copyWith => _$ForgotPasswordEmailSentCopyWithImpl<ForgotPasswordEmailSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordEmailSent&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ForgotPasswordState.emailSent(message: $message)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordEmailSentCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordEmailSentCopyWith(ForgotPasswordEmailSent value, $Res Function(ForgotPasswordEmailSent) _then) = _$ForgotPasswordEmailSentCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ForgotPasswordEmailSentCopyWithImpl<$Res>
    implements $ForgotPasswordEmailSentCopyWith<$Res> {
  _$ForgotPasswordEmailSentCopyWithImpl(this._self, this._then);

  final ForgotPasswordEmailSent _self;
  final $Res Function(ForgotPasswordEmailSent) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ForgotPasswordEmailSent(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordCodeVerified implements ForgotPasswordState {
  const ForgotPasswordCodeVerified({required this.resetToken});
  

 final  String resetToken;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordCodeVerifiedCopyWith<ForgotPasswordCodeVerified> get copyWith => _$ForgotPasswordCodeVerifiedCopyWithImpl<ForgotPasswordCodeVerified>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordCodeVerified&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode => Object.hash(runtimeType,resetToken);

@override
String toString() {
  return 'ForgotPasswordState.codeVerified(resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordCodeVerifiedCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordCodeVerifiedCopyWith(ForgotPasswordCodeVerified value, $Res Function(ForgotPasswordCodeVerified) _then) = _$ForgotPasswordCodeVerifiedCopyWithImpl;
@useResult
$Res call({
 String resetToken
});




}
/// @nodoc
class _$ForgotPasswordCodeVerifiedCopyWithImpl<$Res>
    implements $ForgotPasswordCodeVerifiedCopyWith<$Res> {
  _$ForgotPasswordCodeVerifiedCopyWithImpl(this._self, this._then);

  final ForgotPasswordCodeVerified _self;
  final $Res Function(ForgotPasswordCodeVerified) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? resetToken = null,}) {
  return _then(ForgotPasswordCodeVerified(
resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordSuccess implements ForgotPasswordState {
  const ForgotPasswordSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.success()';
}


}




/// @nodoc


class ForgotPasswordFailure implements ForgotPasswordState {
  const ForgotPasswordFailure({required this.message});
  

 final  String message;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordFailureCopyWith<ForgotPasswordFailure> get copyWith => _$ForgotPasswordFailureCopyWithImpl<ForgotPasswordFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ForgotPasswordState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordFailureCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordFailureCopyWith(ForgotPasswordFailure value, $Res Function(ForgotPasswordFailure) _then) = _$ForgotPasswordFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ForgotPasswordFailureCopyWithImpl<$Res>
    implements $ForgotPasswordFailureCopyWith<$Res> {
  _$ForgotPasswordFailureCopyWithImpl(this._self, this._then);

  final ForgotPasswordFailure _self;
  final $Res Function(ForgotPasswordFailure) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ForgotPasswordFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
