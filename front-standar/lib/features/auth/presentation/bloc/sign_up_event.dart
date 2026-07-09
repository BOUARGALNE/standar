part of 'sign_up_bloc.dart';

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  /// Update form data
  const factory SignUpEvent.formDataUpdated({
    required SignUpFormData formData,
  }) = SignUpFormDataUpdated;

  /// Update individual form fields
  const factory SignUpEvent.fieldUpdated({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    bool? acceptTerms,
    String? country,
  }) = SignUpFieldUpdated;

  /// Send verification code
  const factory SignUpEvent.verificationCodeSendRequested() = SignUpVerificationCodeSendRequested;

  /// Verify code
  const factory SignUpEvent.codeVerifyRequested({
    required String code,
  }) = SignUpCodeVerifyRequested;

  /// Register user
  const factory SignUpEvent.registerRequested() = SignUpRegisterRequested;

  /// Reset state and form data
  const factory SignUpEvent.resetRequested() = SignUpResetRequested;
}
