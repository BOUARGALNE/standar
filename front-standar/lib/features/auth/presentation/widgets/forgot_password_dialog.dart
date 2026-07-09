import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/atoms/buttons/primary_button.dart';
import '../../../../core/ui_kit/atoms/inputs/custom_text_field.dart';
import '../../../../core/ui_kit/atoms/inputs/otp_input.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/feedback/app_toast.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';
import '../../../../core/utils/validators/email_validator.dart';
import '../bloc/forgot_password_bloc.dart';

/// Shows a premium multi-step bottom-sheet dialog for Forgot Password.
Future<void> showForgotPasswordDialog(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: context.read<ForgotPasswordBloc>(),
      child: const ForgotPasswordDialog(),
    ),
  );
}

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int _currentStep = 0; // 0 = Email input, 1 = OTP code, 2 = Reset Password
  String? _otpCode;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitEmail() async {
    if (!(_emailFormKey.currentState?.validate() ?? false)) return;

    final bloc = context.read<ForgotPasswordBloc>();
    bloc.add(ForgotPasswordEvent.emailSendRequested(
      email: _emailController.text.trim(),
    ));

    final state = await bloc.stream.firstWhere(
      (s) => s is! ForgotPasswordLoading,
    );

    if (!mounted) return;

    if (state is ForgotPasswordEmailSent) {
      AppToastHelper.success(
        context,
        'A verification code has been sent to your email.',
        title: 'OTP Sent',
      );
      setState(() => _currentStep = 1);
    } else if (state is ForgotPasswordFailure) {
      AppToastHelper.error(context, state.message, title: 'Error');
    }
  }

  Future<void> _submitOtp(String code) async {
    if (code.length != 6) return;

    _otpCode = code;
    setState(() => _currentStep = 2);
  }

  Future<void> _submitNewPassword() async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;
    if (_otpCode == null) {
      AppToastHelper.error(
          context, 'OTP code is missing. Please start over.');
      return;
    }

    final bloc = context.read<ForgotPasswordBloc>();
    bloc.add(ForgotPasswordEvent.passwordResetRequested(
      email: _emailController.text.trim(),
      otpCode: _otpCode!,
      newPassword: _passwordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
    ));

    final state = await bloc.stream.firstWhere(
      (s) => s is! ForgotPasswordLoading,
    );

    if (!mounted) return;

    if (state is ForgotPasswordSuccess) {
      Navigator.of(context).pop();
      AppToastHelper.success(
        context,
        'Your password has been reset successfully. Please log in.',
        title: 'Password Reset',
      );
    } else if (state is ForgotPasswordFailure) {
      AppToastHelper.error(context, state.message, title: 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, fpState) {
        final isLoading = fpState.isLoading;

        return Container(
          padding: EdgeInsets.only(bottom: bottomInset),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: AppColors.textHint.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Back / Close row & step indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentStep > 0)
                          GestureDetector(
                            onTap: isLoading
                                ? null
                                : () => setState(() => _currentStep--),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.textHint, width: 1),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: 32),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Step ${_currentStep + 1} of 3',
                            style: TextStyle(
                              fontSize: context.responsiveFontSize(12),
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.textHint, width: 1),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Animated step views
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildStepView(isLoading),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepView(bool isLoading) {
    switch (_currentStep) {
      case 0:
        return _buildEmailStep(isLoading);
      case 1:
        return _buildOtpStep(isLoading);
      case 2:
        return _buildPasswordStep(isLoading);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildEmailStep(bool isLoading) {
    return Form(
      key: _emailFormKey,
      child: Column(
        key: const ValueKey('email_step'),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Forgot Password?',
            style: TextStyle(
              fontFamily: AppAssets.montserrat,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Enter your email address and we will send you a 6-digit verification code to reset your password.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 28),
          CustomTextField(
            controller: _emailController,
            label: 'Email Address',
            hintText: 'name@example.com',
            prefixIcon: Icons.alternate_email_rounded,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            enabled: !isLoading,
            validator: (value) => EmailValidator.validate(
              value,
              emptyMessage: 'Email is required',
              invalidMessage: 'Please enter a valid email address',
            ),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Send Verification Code',
            isLoading: isLoading,
            onTap: isLoading ? null : _submitEmail,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpStep(bool isLoading) {
    return Column(
      key: const ValueKey('otp_step'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verification Code',
          style: TextStyle(
            fontFamily: AppAssets.montserrat,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            children: [
              const TextSpan(text: 'We have sent a 6-digit OTP to '),
              TextSpan(
                text: _emailController.text.trim(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const TextSpan(text: '. Please enter it below.'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: OtpInput(
            length: 6,
            onCompleted: isLoading ? null : _submitOtp,
            backgroundColor: AppColors.surface,
            borderColor: AppColors.inputBorder,
            focusedBorderColor: AppColors.primary,
            filledBorderColor: AppColors.primary,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn't receive code? ",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            GestureDetector(
              onTap: isLoading ? null : _submitEmail,
              child: Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPasswordStep(bool isLoading) {
    return Form(
      key: _passwordFormKey,
      child: Column(
        key: const ValueKey('password_step'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reset Password',
            style: TextStyle(
              fontFamily: AppAssets.montserrat,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Enter your new password below. Make sure it is secure.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 28),
          CustomTextField(
            controller: _passwordController,
            label: 'New Password',
            hintText: 'Enter new password',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: true,
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hintText: 'Re-enter your new password',
            prefixIcon: Icons.lock_rounded,
            obscureText: true,
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Reset Password',
            isLoading: isLoading,
            onTap: isLoading ? null : _submitNewPassword,
          ),
        ],
      ),
    );
  }
}
