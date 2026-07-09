part of 'forgot_password_bloc.dart';

@freezed
sealed class ForgotPasswordState with _$ForgotPasswordState {
  /// Initial state — no attempt
  const factory ForgotPasswordState.initial() = ForgotPasswordInitial;

  /// Loading state — API request in progress
  const factory ForgotPasswordState.loading({
    required ForgotPasswordLoadingAction action,
    String? message,
  }) = ForgotPasswordLoading;

  /// Email sent successfully
  const factory ForgotPasswordState.emailSent({
    required String message,
  }) = ForgotPasswordEmailSent;

  /// Code verified successfully
  const factory ForgotPasswordState.codeVerified({
    required String resetToken,
  }) = ForgotPasswordCodeVerified;

  /// Password reset completed successfully
  const factory ForgotPasswordState.success() = ForgotPasswordSuccess;

  /// Error state
  const factory ForgotPasswordState.failure({
    required String message,
  }) = ForgotPasswordFailure;
}

/// Loading action types for forgot password
enum ForgotPasswordLoadingAction {
  sendingEmail,
  verifyingCode,
  resettingPassword,
}

/// Extension to check loading states
extension ForgotPasswordStateX on ForgotPasswordState {
  bool get isLoading => this is ForgotPasswordLoading;

  bool get isSendingEmail =>
      this is ForgotPasswordLoading &&
      (this as ForgotPasswordLoading).action ==
          ForgotPasswordLoadingAction.sendingEmail;

  bool get isVerifyingCode =>
      this is ForgotPasswordLoading &&
      (this as ForgotPasswordLoading).action ==
          ForgotPasswordLoadingAction.verifyingCode;

  bool get isResettingPassword =>
      this is ForgotPasswordLoading &&
      (this as ForgotPasswordLoading).action ==
          ForgotPasswordLoadingAction.resettingPassword;
}
