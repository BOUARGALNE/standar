part of 'forgot_password_bloc.dart';

@freezed
sealed class ForgotPasswordEvent with _$ForgotPasswordEvent {
  /// Send forgot password email
  const factory ForgotPasswordEvent.emailSendRequested({
    required String email,
  }) = ForgotPasswordEmailSendRequested;

  /// Verify OTP code
  const factory ForgotPasswordEvent.codeVerifyRequested({
    required String email,
    required String code,
  }) = ForgotPasswordCodeVerifyRequested;

  /// Reset password
  const factory ForgotPasswordEvent.passwordResetRequested({
    required String email,
    required String otpCode,
    required String newPassword,
    required String confirmPassword,
  }) = ForgotPasswordPasswordResetRequested;

  /// Reset state
  const factory ForgotPasswordEvent.resetRequested() =
      ForgotPasswordResetRequested;
}
