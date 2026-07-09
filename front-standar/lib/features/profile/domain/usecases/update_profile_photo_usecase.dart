import 'dart:io';

import '../repositories/profile_repository.dart';

class UpdateProfilePhotoUseCase {
  const UpdateProfilePhotoUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call(File file) {
    return _repository.updateProfilePhoto(file);
  }
}
