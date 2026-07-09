// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent()';
}


}

/// @nodoc
class $SignUpEventCopyWith<$Res>  {
$SignUpEventCopyWith(SignUpEvent _, $Res Function(SignUpEvent) __);
}


/// Adds pattern-matching-related methods to [SignUpEvent].
extension SignUpEventPatterns on SignUpEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignUpFormDataUpdated value)?  formDataUpdated,TResult Function( SignUpFieldUpdated value)?  fieldUpdated,TResult Function( SignUpVerificationCodeSendRequested value)?  verificationCodeSendRequested,TResult Function( SignUpCodeVerifyRequested value)?  codeVerifyRequested,TResult Function( SignUpRegisterRequested value)?  registerRequested,TResult Function( SignUpResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignUpFormDataUpdated() when formDataUpdated != null:
return formDataUpdated(_that);case SignUpFieldUpdated() when fieldUpdated != null:
return fieldUpdated(_that);case SignUpVerificationCodeSendRequested() when verificationCodeSendRequested != null:
return verificationCodeSendRequested(_that);case SignUpCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that);case SignUpRegisterRequested() when registerRequested != null:
return registerRequested(_that);case SignUpResetRequested() when resetRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignUpFormDataUpdated value)  formDataUpdated,required TResult Function( SignUpFieldUpdated value)  fieldUpdated,required TResult Function( SignUpVerificationCodeSendRequested value)  verificationCodeSendRequested,required TResult Function( SignUpCodeVerifyRequested value)  codeVerifyRequested,required TResult Function( SignUpRegisterRequested value)  registerRequested,required TResult Function( SignUpResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case SignUpFormDataUpdated():
return formDataUpdated(_that);case SignUpFieldUpdated():
return fieldUpdated(_that);case SignUpVerificationCodeSendRequested():
return verificationCodeSendRequested(_that);case SignUpCodeVerifyRequested():
return codeVerifyRequested(_that);case SignUpRegisterRequested():
return registerRequested(_that);case SignUpResetRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignUpFormDataUpdated value)?  formDataUpdated,TResult? Function( SignUpFieldUpdated value)?  fieldUpdated,TResult? Function( SignUpVerificationCodeSendRequested value)?  verificationCodeSendRequested,TResult? Function( SignUpCodeVerifyRequested value)?  codeVerifyRequested,TResult? Function( SignUpRegisterRequested value)?  registerRequested,TResult? Function( SignUpResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case SignUpFormDataUpdated() when formDataUpdated != null:
return formDataUpdated(_that);case SignUpFieldUpdated() when fieldUpdated != null:
return fieldUpdated(_that);case SignUpVerificationCodeSendRequested() when verificationCodeSendRequested != null:
return verificationCodeSendRequested(_that);case SignUpCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that);case SignUpRegisterRequested() when registerRequested != null:
return registerRequested(_that);case SignUpResetRequested() when resetRequested != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SignUpFormData formData)?  formDataUpdated,TResult Function( String? firstName,  String? lastName,  String? email,  String? phone,  String? password,  bool? acceptTerms,  String? country)?  fieldUpdated,TResult Function()?  verificationCodeSendRequested,TResult Function( String code)?  codeVerifyRequested,TResult Function()?  registerRequested,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignUpFormDataUpdated() when formDataUpdated != null:
return formDataUpdated(_that.formData);case SignUpFieldUpdated() when fieldUpdated != null:
return fieldUpdated(_that.firstName,_that.lastName,_that.email,_that.phone,_that.password,_that.acceptTerms,_that.country);case SignUpVerificationCodeSendRequested() when verificationCodeSendRequested != null:
return verificationCodeSendRequested();case SignUpCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that.code);case SignUpRegisterRequested() when registerRequested != null:
return registerRequested();case SignUpResetRequested() when resetRequested != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SignUpFormData formData)  formDataUpdated,required TResult Function( String? firstName,  String? lastName,  String? email,  String? phone,  String? password,  bool? acceptTerms,  String? country)  fieldUpdated,required TResult Function()  verificationCodeSendRequested,required TResult Function( String code)  codeVerifyRequested,required TResult Function()  registerRequested,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case SignUpFormDataUpdated():
return formDataUpdated(_that.formData);case SignUpFieldUpdated():
return fieldUpdated(_that.firstName,_that.lastName,_that.email,_that.phone,_that.password,_that.acceptTerms,_that.country);case SignUpVerificationCodeSendRequested():
return verificationCodeSendRequested();case SignUpCodeVerifyRequested():
return codeVerifyRequested(_that.code);case SignUpRegisterRequested():
return registerRequested();case SignUpResetRequested():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SignUpFormData formData)?  formDataUpdated,TResult? Function( String? firstName,  String? lastName,  String? email,  String? phone,  String? password,  bool? acceptTerms,  String? country)?  fieldUpdated,TResult? Function()?  verificationCodeSendRequested,TResult? Function( String code)?  codeVerifyRequested,TResult? Function()?  registerRequested,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case SignUpFormDataUpdated() when formDataUpdated != null:
return formDataUpdated(_that.formData);case SignUpFieldUpdated() when fieldUpdated != null:
return fieldUpdated(_that.firstName,_that.lastName,_that.email,_that.phone,_that.password,_that.acceptTerms,_that.country);case SignUpVerificationCodeSendRequested() when verificationCodeSendRequested != null:
return verificationCodeSendRequested();case SignUpCodeVerifyRequested() when codeVerifyRequested != null:
return codeVerifyRequested(_that.code);case SignUpRegisterRequested() when registerRequested != null:
return registerRequested();case SignUpResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class SignUpFormDataUpdated implements SignUpEvent {
  const SignUpFormDataUpdated({required this.formData});
  

 final  SignUpFormData formData;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpFormDataUpdatedCopyWith<SignUpFormDataUpdated> get copyWith => _$SignUpFormDataUpdatedCopyWithImpl<SignUpFormDataUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpFormDataUpdated&&(identical(other.formData, formData) || other.formData == formData));
}


@override
int get hashCode => Object.hash(runtimeType,formData);

@override
String toString() {
  return 'SignUpEvent.formDataUpdated(formData: $formData)';
}


}

/// @nodoc
abstract mixin class $SignUpFormDataUpdatedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory $SignUpFormDataUpdatedCopyWith(SignUpFormDataUpdated value, $Res Function(SignUpFormDataUpdated) _then) = _$SignUpFormDataUpdatedCopyWithImpl;
@useResult
$Res call({
 SignUpFormData formData
});




}
/// @nodoc
class _$SignUpFormDataUpdatedCopyWithImpl<$Res>
    implements $SignUpFormDataUpdatedCopyWith<$Res> {
  _$SignUpFormDataUpdatedCopyWithImpl(this._self, this._then);

  final SignUpFormDataUpdated _self;
  final $Res Function(SignUpFormDataUpdated) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? formData = null,}) {
  return _then(SignUpFormDataUpdated(
formData: null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as SignUpFormData,
  ));
}


}

/// @nodoc


class SignUpFieldUpdated implements SignUpEvent {
  const SignUpFieldUpdated({this.firstName, this.lastName, this.email, this.phone, this.password, this.acceptTerms, this.country});
  

 final  String? firstName;
 final  String? lastName;
 final  String? email;
 final  String? phone;
 final  String? password;
 final  bool? acceptTerms;
 final  String? country;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpFieldUpdatedCopyWith<SignUpFieldUpdated> get copyWith => _$SignUpFieldUpdatedCopyWithImpl<SignUpFieldUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpFieldUpdated&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.acceptTerms, acceptTerms) || other.acceptTerms == acceptTerms)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,phone,password,acceptTerms,country);

@override
String toString() {
  return 'SignUpEvent.fieldUpdated(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, password: $password, acceptTerms: $acceptTerms, country: $country)';
}


}

/// @nodoc
abstract mixin class $SignUpFieldUpdatedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory $SignUpFieldUpdatedCopyWith(SignUpFieldUpdated value, $Res Function(SignUpFieldUpdated) _then) = _$SignUpFieldUpdatedCopyWithImpl;
@useResult
$Res call({
 String? firstName, String? lastName, String? email, String? phone, String? password, bool? acceptTerms, String? country
});




}
/// @nodoc
class _$SignUpFieldUpdatedCopyWithImpl<$Res>
    implements $SignUpFieldUpdatedCopyWith<$Res> {
  _$SignUpFieldUpdatedCopyWithImpl(this._self, this._then);

  final SignUpFieldUpdated _self;
  final $Res Function(SignUpFieldUpdated) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? phone = freezed,Object? password = freezed,Object? acceptTerms = freezed,Object? country = freezed,}) {
  return _then(SignUpFieldUpdated(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,acceptTerms: freezed == acceptTerms ? _self.acceptTerms : acceptTerms // ignore: cast_nullable_to_non_nullable
as bool?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SignUpVerificationCodeSendRequested implements SignUpEvent {
  const SignUpVerificationCodeSendRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpVerificationCodeSendRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.verificationCodeSendRequested()';
}


}




/// @nodoc


class SignUpCodeVerifyRequested implements SignUpEvent {
  const SignUpCodeVerifyRequested({required this.code});
  

 final  String code;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpCodeVerifyRequestedCopyWith<SignUpCodeVerifyRequested> get copyWith => _$SignUpCodeVerifyRequestedCopyWithImpl<SignUpCodeVerifyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpCodeVerifyRequested&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'SignUpEvent.codeVerifyRequested(code: $code)';
}


}

/// @nodoc
abstract mixin class $SignUpCodeVerifyRequestedCopyWith<$Res> implements $SignUpEventCopyWith<$Res> {
  factory $SignUpCodeVerifyRequestedCopyWith(SignUpCodeVerifyRequested value, $Res Function(SignUpCodeVerifyRequested) _then) = _$SignUpCodeVerifyRequestedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$SignUpCodeVerifyRequestedCopyWithImpl<$Res>
    implements $SignUpCodeVerifyRequestedCopyWith<$Res> {
  _$SignUpCodeVerifyRequestedCopyWithImpl(this._self, this._then);

  final SignUpCodeVerifyRequested _self;
  final $Res Function(SignUpCodeVerifyRequested) _then;

/// Create a copy of SignUpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(SignUpCodeVerifyRequested(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignUpRegisterRequested implements SignUpEvent {
  const SignUpRegisterRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpRegisterRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.registerRequested()';
}


}




/// @nodoc


class SignUpResetRequested implements SignUpEvent {
  const SignUpResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpEvent.resetRequested()';
}


}




/// @nodoc
mixin _$SignUpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState()';
}


}

/// @nodoc
class $SignUpStateCopyWith<$Res>  {
$SignUpStateCopyWith(SignUpState _, $Res Function(SignUpState) __);
}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignUpInitial value)?  initial,TResult Function( SignUpLoading value)?  loading,TResult Function( SignUpVerificationCodeSent value)?  verificationCodeSent,TResult Function( SignUpVerificationCodeVerified value)?  verificationCodeVerified,TResult Function( SignUpSuccess value)?  success,TResult Function( SignUpFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignUpInitial() when initial != null:
return initial(_that);case SignUpLoading() when loading != null:
return loading(_that);case SignUpVerificationCodeSent() when verificationCodeSent != null:
return verificationCodeSent(_that);case SignUpVerificationCodeVerified() when verificationCodeVerified != null:
return verificationCodeVerified(_that);case SignUpSuccess() when success != null:
return success(_that);case SignUpFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignUpInitial value)  initial,required TResult Function( SignUpLoading value)  loading,required TResult Function( SignUpVerificationCodeSent value)  verificationCodeSent,required TResult Function( SignUpVerificationCodeVerified value)  verificationCodeVerified,required TResult Function( SignUpSuccess value)  success,required TResult Function( SignUpFailure value)  failure,}){
final _that = this;
switch (_that) {
case SignUpInitial():
return initial(_that);case SignUpLoading():
return loading(_that);case SignUpVerificationCodeSent():
return verificationCodeSent(_that);case SignUpVerificationCodeVerified():
return verificationCodeVerified(_that);case SignUpSuccess():
return success(_that);case SignUpFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignUpInitial value)?  initial,TResult? Function( SignUpLoading value)?  loading,TResult? Function( SignUpVerificationCodeSent value)?  verificationCodeSent,TResult? Function( SignUpVerificationCodeVerified value)?  verificationCodeVerified,TResult? Function( SignUpSuccess value)?  success,TResult? Function( SignUpFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SignUpInitial() when initial != null:
return initial(_that);case SignUpLoading() when loading != null:
return loading(_that);case SignUpVerificationCodeSent() when verificationCodeSent != null:
return verificationCodeSent(_that);case SignUpVerificationCodeVerified() when verificationCodeVerified != null:
return verificationCodeVerified(_that);case SignUpSuccess() when success != null:
return success(_that);case SignUpFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( SignUpLoadingAction action,  String? message)?  loading,TResult Function( String message)?  verificationCodeSent,TResult Function()?  verificationCodeVerified,TResult Function( AuthSession session)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignUpInitial() when initial != null:
return initial();case SignUpLoading() when loading != null:
return loading(_that.action,_that.message);case SignUpVerificationCodeSent() when verificationCodeSent != null:
return verificationCodeSent(_that.message);case SignUpVerificationCodeVerified() when verificationCodeVerified != null:
return verificationCodeVerified();case SignUpSuccess() when success != null:
return success(_that.session);case SignUpFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( SignUpLoadingAction action,  String? message)  loading,required TResult Function( String message)  verificationCodeSent,required TResult Function()  verificationCodeVerified,required TResult Function( AuthSession session)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case SignUpInitial():
return initial();case SignUpLoading():
return loading(_that.action,_that.message);case SignUpVerificationCodeSent():
return verificationCodeSent(_that.message);case SignUpVerificationCodeVerified():
return verificationCodeVerified();case SignUpSuccess():
return success(_that.session);case SignUpFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( SignUpLoadingAction action,  String? message)?  loading,TResult? Function( String message)?  verificationCodeSent,TResult? Function()?  verificationCodeVerified,TResult? Function( AuthSession session)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case SignUpInitial() when initial != null:
return initial();case SignUpLoading() when loading != null:
return loading(_that.action,_that.message);case SignUpVerificationCodeSent() when verificationCodeSent != null:
return verificationCodeSent(_that.message);case SignUpVerificationCodeVerified() when verificationCodeVerified != null:
return verificationCodeVerified();case SignUpSuccess() when success != null:
return success(_that.session);case SignUpFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SignUpInitial implements SignUpState {
  const SignUpInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.initial()';
}


}




/// @nodoc


class SignUpLoading implements SignUpState {
  const SignUpLoading({required this.action, this.message});
  

 final  SignUpLoadingAction action;
 final  String? message;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpLoadingCopyWith<SignUpLoading> get copyWith => _$SignUpLoadingCopyWithImpl<SignUpLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpLoading&&(identical(other.action, action) || other.action == action)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,message);

@override
String toString() {
  return 'SignUpState.loading(action: $action, message: $message)';
}


}

/// @nodoc
abstract mixin class $SignUpLoadingCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory $SignUpLoadingCopyWith(SignUpLoading value, $Res Function(SignUpLoading) _then) = _$SignUpLoadingCopyWithImpl;
@useResult
$Res call({
 SignUpLoadingAction action, String? message
});




}
/// @nodoc
class _$SignUpLoadingCopyWithImpl<$Res>
    implements $SignUpLoadingCopyWith<$Res> {
  _$SignUpLoadingCopyWithImpl(this._self, this._then);

  final SignUpLoading _self;
  final $Res Function(SignUpLoading) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,Object? message = freezed,}) {
  return _then(SignUpLoading(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SignUpLoadingAction,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SignUpVerificationCodeSent implements SignUpState {
  const SignUpVerificationCodeSent({required this.message});
  

 final  String message;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpVerificationCodeSentCopyWith<SignUpVerificationCodeSent> get copyWith => _$SignUpVerificationCodeSentCopyWithImpl<SignUpVerificationCodeSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpVerificationCodeSent&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SignUpState.verificationCodeSent(message: $message)';
}


}

/// @nodoc
abstract mixin class $SignUpVerificationCodeSentCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory $SignUpVerificationCodeSentCopyWith(SignUpVerificationCodeSent value, $Res Function(SignUpVerificationCodeSent) _then) = _$SignUpVerificationCodeSentCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SignUpVerificationCodeSentCopyWithImpl<$Res>
    implements $SignUpVerificationCodeSentCopyWith<$Res> {
  _$SignUpVerificationCodeSentCopyWithImpl(this._self, this._then);

  final SignUpVerificationCodeSent _self;
  final $Res Function(SignUpVerificationCodeSent) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SignUpVerificationCodeSent(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignUpVerificationCodeVerified implements SignUpState {
  const SignUpVerificationCodeVerified();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpVerificationCodeVerified);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.verificationCodeVerified()';
}


}




/// @nodoc


class SignUpSuccess implements SignUpState {
  const SignUpSuccess({required this.session});
  

 final  AuthSession session;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpSuccessCopyWith<SignUpSuccess> get copyWith => _$SignUpSuccessCopyWithImpl<SignUpSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpSuccess&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'SignUpState.success(session: $session)';
}


}

/// @nodoc
abstract mixin class $SignUpSuccessCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory $SignUpSuccessCopyWith(SignUpSuccess value, $Res Function(SignUpSuccess) _then) = _$SignUpSuccessCopyWithImpl;
@useResult
$Res call({
 AuthSession session
});




}
/// @nodoc
class _$SignUpSuccessCopyWithImpl<$Res>
    implements $SignUpSuccessCopyWith<$Res> {
  _$SignUpSuccessCopyWithImpl(this._self, this._then);

  final SignUpSuccess _self;
  final $Res Function(SignUpSuccess) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(SignUpSuccess(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as AuthSession,
  ));
}


}

/// @nodoc


class SignUpFailure implements SignUpState {
  const SignUpFailure({required this.message});
  

 final  String message;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpFailureCopyWith<SignUpFailure> get copyWith => _$SignUpFailureCopyWithImpl<SignUpFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SignUpState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SignUpFailureCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory $SignUpFailureCopyWith(SignUpFailure value, $Res Function(SignUpFailure) _then) = _$SignUpFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SignUpFailureCopyWithImpl<$Res>
    implements $SignUpFailureCopyWith<$Res> {
  _$SignUpFailureCopyWithImpl(this._self, this._then);

  final SignUpFailure _self;
  final $Res Function(SignUpFailure) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SignUpFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
