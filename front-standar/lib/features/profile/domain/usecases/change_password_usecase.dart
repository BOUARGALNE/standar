import '../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  const ChangePasswordUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call({
    String? oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return _repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
