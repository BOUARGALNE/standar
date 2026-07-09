import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_photo_usecase.dart';
import '../../domain/usecases/update_profile_info_usecase.dart';
import '../../../../core/networking/exceptions/api_exception.dart';
import 'profile_event.dart';
import 'profile_state.dart';

export 'profile_event.dart';
export 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfilePhotoUseCase updateProfilePhotoUseCase,
    required UpdateProfileInfoUseCase updateProfileInfoUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfilePhotoUseCase = updateProfilePhotoUseCase,
        _updateProfileInfoUseCase = updateProfileInfoUseCase,
        super(const ProfileState.initial()) {
    on<ProfileFetchRequested>(_onFetchRequested);
    on<ProfilePhotoUpdateRequested>(_onPhotoUpdateRequested);
    on<ProfileInfoUpdateRequested>(_onInfoUpdateRequested);
  }

  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfilePhotoUseCase _updateProfilePhotoUseCase;
  final UpdateProfileInfoUseCase _updateProfileInfoUseCase;

  Future<void> _onFetchRequested(
    ProfileFetchRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());
    try {
      final user = await _getProfileUseCase();
      emit(ProfileState.success(user));
    } on ApiException catch (e) {
      emit(ProfileState.failure(e.message));
    } catch (e) {
      emit(ProfileState.failure('An unexpected error occurred.'));
    }
  }

  Future<void> _onPhotoUpdateRequested(
    ProfilePhotoUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());
    try {
      await _updateProfilePhotoUseCase(event.file);
      // Re-fetch profile to get the updated URL
      add(const ProfileEvent.fetchRequested());
    } on ApiException catch (e) {
      emit(ProfileState.failure(e.message));
    } catch (e) {
      emit(ProfileState.failure('An unexpected error occurred.'));
    }
  }

  Future<void> _onInfoUpdateRequested(
    ProfileInfoUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // Don't show full-screen loading — the dialog handles its own loading state
    try {
      final updatedUser = await _updateProfileInfoUseCase(
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        country: event.country,
      );
      emit(ProfileState.success(updatedUser));
    } catch (e) {
      // Re-emit current state so UI doesn't break, the dialog handles the error
      rethrow;
    }
  }
}
