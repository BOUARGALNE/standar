part of 'sign_up_bloc.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  /// Initial state — no signup attempt
  const factory SignUpState.initial() = SignUpInitial;

  /// Loading state — API request in progress
  const factory SignUpState.loading({
    required SignUpLoadingAction action,
    String? message,
  }) = SignUpLoading;

  /// Verification code sent successfully
  const factory SignUpState.verificationCodeSent({
    required String message,
  }) = SignUpVerificationCodeSent;

  /// Verification code verified successfully
  const factory SignUpState.verificationCodeVerified() =
      SignUpVerificationCodeVerified;

  /// Sign up completed successfully
  const factory SignUpState.success({
    required AuthSession session,
  }) = SignUpSuccess;

  /// Error state
  const factory SignUpState.failure({
    required String message,
  }) = SignUpFailure;
}

/// Loading action types for signup
enum SignUpLoadingAction { sendingCode, verifyingCode, registering }

/// Extension to check loading states
extension SignUpStateX on SignUpState {
  bool get isLoading => this is SignUpLoading;

  bool get isSendingCode =>
      this is SignUpLoading &&
      (this as SignUpLoading).action == SignUpLoadingAction.sendingCode;

  bool get isVerifyingCode =>
      this is SignUpLoading &&
      (this as SignUpLoading).action == SignUpLoadingAction.verifyingCode;

  bool get isRegistering =>
      this is SignUpLoading &&
      (this as SignUpLoading).action == SignUpLoadingAction.registering;
}
