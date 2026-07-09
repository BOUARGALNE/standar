// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileFetchRequested value)?  fetchRequested,TResult Function( ProfilePhotoUpdateRequested value)?  photoUpdateRequested,TResult Function( ProfileInfoUpdateRequested value)?  infoUpdateRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case ProfilePhotoUpdateRequested() when photoUpdateRequested != null:
return photoUpdateRequested(_that);case ProfileInfoUpdateRequested() when infoUpdateRequested != null:
return infoUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileFetchRequested value)  fetchRequested,required TResult Function( ProfilePhotoUpdateRequested value)  photoUpdateRequested,required TResult Function( ProfileInfoUpdateRequested value)  infoUpdateRequested,}){
final _that = this;
switch (_that) {
case ProfileFetchRequested():
return fetchRequested(_that);case ProfilePhotoUpdateRequested():
return photoUpdateRequested(_that);case ProfileInfoUpdateRequested():
return infoUpdateRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileFetchRequested value)?  fetchRequested,TResult? Function( ProfilePhotoUpdateRequested value)?  photoUpdateRequested,TResult? Function( ProfileInfoUpdateRequested value)?  infoUpdateRequested,}){
final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case ProfilePhotoUpdateRequested() when photoUpdateRequested != null:
return photoUpdateRequested(_that);case ProfileInfoUpdateRequested() when infoUpdateRequested != null:
return infoUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchRequested,TResult Function( File file)?  photoUpdateRequested,TResult Function( String? firstName,  String? lastName,  String? phone,  String? country)?  infoUpdateRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested();case ProfilePhotoUpdateRequested() when photoUpdateRequested != null:
return photoUpdateRequested(_that.file);case ProfileInfoUpdateRequested() when infoUpdateRequested != null:
return infoUpdateRequested(_that.firstName,_that.lastName,_that.phone,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchRequested,required TResult Function( File file)  photoUpdateRequested,required TResult Function( String? firstName,  String? lastName,  String? phone,  String? country)  infoUpdateRequested,}) {final _that = this;
switch (_that) {
case ProfileFetchRequested():
return fetchRequested();case ProfilePhotoUpdateRequested():
return photoUpdateRequested(_that.file);case ProfileInfoUpdateRequested():
return infoUpdateRequested(_that.firstName,_that.lastName,_that.phone,_that.country);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchRequested,TResult? Function( File file)?  photoUpdateRequested,TResult? Function( String? firstName,  String? lastName,  String? phone,  String? country)?  infoUpdateRequested,}) {final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested();case ProfilePhotoUpdateRequested() when photoUpdateRequested != null:
return photoUpdateRequested(_that.file);case ProfileInfoUpdateRequested() when infoUpdateRequested != null:
return infoUpdateRequested(_that.firstName,_that.lastName,_that.phone,_that.country);case _:
  return null;

}
}

}

/// @nodoc


class ProfileFetchRequested implements ProfileEvent {
  const ProfileFetchRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileFetchRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.fetchRequested()';
}


}




/// @nodoc


class ProfilePhotoUpdateRequested implements ProfileEvent {
  const ProfilePhotoUpdateRequested(this.file);
  

 final  File file;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePhotoUpdateRequestedCopyWith<ProfilePhotoUpdateRequested> get copyWith => _$ProfilePhotoUpdateRequestedCopyWithImpl<ProfilePhotoUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePhotoUpdateRequested&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'ProfileEvent.photoUpdateRequested(file: $file)';
}


}

/// @nodoc
abstract mixin class $ProfilePhotoUpdateRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfilePhotoUpdateRequestedCopyWith(ProfilePhotoUpdateRequested value, $Res Function(ProfilePhotoUpdateRequested) _then) = _$ProfilePhotoUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 File file
});




}
/// @nodoc
class _$ProfilePhotoUpdateRequestedCopyWithImpl<$Res>
    implements $ProfilePhotoUpdateRequestedCopyWith<$Res> {
  _$ProfilePhotoUpdateRequestedCopyWithImpl(this._self, this._then);

  final ProfilePhotoUpdateRequested _self;
  final $Res Function(ProfilePhotoUpdateRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(ProfilePhotoUpdateRequested(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class ProfileInfoUpdateRequested implements ProfileEvent {
  const ProfileInfoUpdateRequested({this.firstName, this.lastName, this.phone, this.country});
  

 final  String? firstName;
 final  String? lastName;
 final  String? phone;
 final  String? country;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileInfoUpdateRequestedCopyWith<ProfileInfoUpdateRequested> get copyWith => _$ProfileInfoUpdateRequestedCopyWithImpl<ProfileInfoUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileInfoUpdateRequested&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,phone,country);

@override
String toString() {
  return 'ProfileEvent.infoUpdateRequested(firstName: $firstName, lastName: $lastName, phone: $phone, country: $country)';
}


}

/// @nodoc
abstract mixin class $ProfileInfoUpdateRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileInfoUpdateRequestedCopyWith(ProfileInfoUpdateRequested value, $Res Function(ProfileInfoUpdateRequested) _then) = _$ProfileInfoUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String? firstName, String? lastName, String? phone, String? country
});




}
/// @nodoc
class _$ProfileInfoUpdateRequestedCopyWithImpl<$Res>
    implements $ProfileInfoUpdateRequestedCopyWith<$Res> {
  _$ProfileInfoUpdateRequestedCopyWithImpl(this._self, this._then);

  final ProfileInfoUpdateRequested _self;
  final $Res Function(ProfileInfoUpdateRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? phone = freezed,Object? country = freezed,}) {
  return _then(ProfileInfoUpdateRequested(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
