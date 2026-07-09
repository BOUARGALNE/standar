import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
sealed class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.fetchRequested() = ProfileFetchRequested;
  const factory ProfileEvent.photoUpdateRequested(File file) = ProfilePhotoUpdateRequested;
  const factory ProfileEvent.infoUpdateRequested({
    String? firstName,
    String? lastName,
    String? phone,
    String? country,
  }) = ProfileInfoUpdateRequested;
}
