import '../entities/verify_reset_code_result.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this._repository);
  final AuthRepository _repository;

  Future<bool> call(String email) => _repository.forgotPassword(email);
}

class VerifyResetCodeUseCase {
  const VerifyResetCodeUseCase(this._repository);
  final AuthRepository _repository;

  Future<VerifyResetCodeResult> call(String email, String code) =>
      _repository.verifyResetCode(email, code);
}

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);
  final AuthRepository _repository;

  Future<bool> call({
    required String email,
    required String otpCode,
    required String newPassword,
    required String confirmPassword,
  }) =>
      _repository.resetPassword(
        email: email,
        otpCode: otpCode,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
}
