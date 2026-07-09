
import 'package:flutter/material.dart';

import '../../../../core/ui_kit/atoms/inputs/custom_text_field.dart';
import '../../../../core/utils/validators/email_validator.dart';
import '../../../../core/utils/validators/password_validator.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';


/// Form section of the Sign In screen.
///
/// Contains the email field, password field, and "Forgot Password?" link.
/// All logic (validation, loading state) is passed from the parent screen.
class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    this.onForgotPassword,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback? onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Email field ───────────────────────────────────────────────
        CustomTextField(
          controller: emailController,
          label: 'Email',
          hintText: 'your@email.com',
          prefixIcon: Icons.alternate_email_rounded,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          enabled: !isLoading,
          validator: (value) => EmailValidator.validate(
            value,
            emptyMessage: 'Please enter your email',
            invalidMessage: 'Please enter a valid email',
          ),
        ),

        SizedBox(height: context.responsiveHeight(15)),

        // ── Password field ────────────────────────────────────────────
        CustomTextField(
          controller: passwordController,
          label: 'Password',
          hintText: '••••••••',
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: true,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          enabled: !isLoading,
          validator: (value) => PasswordValidator.validateNotEmpty(
            value,
            emptyMessage: 'Please enter your password',
          ),
        ),

        SizedBox(height: context.responsiveHeight(10)),

        // ── Forgot password link ──────────────────────────────────────
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: isLoading ? null : onForgotPassword,
            child: Text(
              'Forgot password?',
              style: TextStyle(
                fontSize: context.responsiveFontSize(13),
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
