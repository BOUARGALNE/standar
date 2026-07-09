import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/networking/exceptions/api_exception.dart';
import '../../domain/usecases/forgot_password_usecases.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

/// Bloc for the forgot-password flow.
///
/// Follows the proper Bloc pattern with Event → State.
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required VerifyResetCodeUseCase verifyResetCodeUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _forgotPasswordUseCase = forgotPasswordUseCase,
        _verifyResetCodeUseCase = verifyResetCodeUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(const ForgotPasswordState.initial()) {
    on<ForgotPasswordEmailSendRequested>(_onEmailSendRequested);
    on<ForgotPasswordCodeVerifyRequested>(_onCodeVerifyRequested);
    on<ForgotPasswordPasswordResetRequested>(_onPasswordResetRequested);
    on<ForgotPasswordResetRequested>(_onResetRequested);
  }

  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  // ── Event handlers ─────────────────────────────────────────────────────────

  Future<void> _onEmailSendRequested(
    ForgotPasswordEmailSendRequested event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordState.loading(
      action: ForgotPasswordLoadingAction.sendingEmail,
      message: 'Sending verification code...',
    ));

    try {
      final success = await _forgotPasswordUseCase(event.email);

      if (success) {
        emit(const ForgotPasswordState.emailSent(
          message: 'A verification code has been sent to your email.',
        ));
      } else {
        emit(const ForgotPasswordState.failure(
          message: 'Failed to send verification code. Please try again.',
        ));
      }
    } on ApiException catch (e) {
      emit(ForgotPasswordState.failure(message: e.message));
    } catch (e) {
      emit(ForgotPasswordState.failure(message: e.toString()));
    }
  }

  Future<void> _onCodeVerifyRequested(
    ForgotPasswordCodeVerifyRequested event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordState.loading(
      action: ForgotPasswordLoadingAction.verifyingCode,
      message: 'Verifying code...',
    ));

    try {
      final result = await _verifyResetCodeUseCase(event.email, event.code);

      if (result.success && result.resetToken != null) {
        emit(ForgotPasswordState.codeVerified(
          resetToken: result.resetToken!,
        ));
      } else {
        emit(ForgotPasswordState.failure(
          message: result.message.isNotEmpty
              ? result.message
              : 'Invalid code, please try again.',
        ));
      }
    } on ApiException catch (e) {
      emit(ForgotPasswordState.failure(message: e.message));
    } catch (e) {
      emit(ForgotPasswordState.failure(message: e.toString()));
    }
  }

  Future<void> _onPasswordResetRequested(
    ForgotPasswordPasswordResetRequested event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordState.loading(
      action: ForgotPasswordLoadingAction.resettingPassword,
      message: 'Resetting password...',
    ));

    try {
      final success = await _resetPasswordUseCase(
        email: event.email,
        otpCode: event.otpCode,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );

      if (success) {
        emit(const ForgotPasswordState.success());
      } else {
        emit(const ForgotPasswordState.failure(
          message: 'Failed to reset password. Please try again.',
        ));
      }
    } on ApiException catch (e) {
      emit(ForgotPasswordState.failure(message: e.message));
    } catch (e) {
      emit(ForgotPasswordState.failure(message: e.toString()));
    }
  }

  void _onResetRequested(
    ForgotPasswordResetRequested event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(const ForgotPasswordState.initial());
  }
}
