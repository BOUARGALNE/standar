import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/atoms/buttons/primary_button.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/organisms/step_headline.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';
import 'otp_section.dart';

/// Step 2 of the Sign Up flow — email verification.
///
/// - Displays the email collected in Step 1 (read-only)
/// - Shows the 6-digit OTP input
/// - "Verify & Continue" submits the code
class EmailVerificationStep extends StatefulWidget {
  const EmailVerificationStep({
    super.key,
    required this.email,
    required this.onVerified,
    required this.onBack,
    this.isLoading = false,
    this.onResendCode,
    this.onVerifyCode,
  });

  /// Email address collected in Step 1.
  final String email;

  /// Called when verification succeeds.
  final VoidCallback onVerified;

  /// Called when the user taps the back button.
  final VoidCallback onBack;

  /// External loading state controlled by the parent/controller.
  final bool isLoading;

  /// Called when "Resend code" is tapped.
  final Future<void> Function()? onResendCode;

  /// Called with the 6-digit code when the user taps "Verify & Continue".
  final Future<bool> Function(String code)? onVerifyCode;

  @override
  State<EmailVerificationStep> createState() => _EmailVerificationStepState();
}

class _EmailVerificationStepState extends State<EmailVerificationStep> {
  String _otpCode = '';
  bool _isResending = false;
  bool _codeSent = false;

  bool get _canVerify => _otpCode.length == 6 && !widget.isLoading;

  @override
  void initState() {
    super.initState();
    // Auto-send verification code when step is first shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_codeSent) {
        _handleResend();
        _codeSent = true;
      }
    });
  }

  Future<void> _handleVerify() async {
    if (!_canVerify) return;
    if (widget.onVerifyCode != null) {
      final success = await widget.onVerifyCode!(_otpCode);
      if (success && mounted) widget.onVerified();
    } else {
      widget.onVerified();
    }
  }

  Future<void> _handleResend() async {
    setState(() => _isResending = true);
    await widget.onResendCode?.call();
    if (mounted) setState(() => _isResending = false);
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveWidth(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.responsiveHeight(24)),
                    // Headline
                    GestureDetector(
                      onTap: ()=>widget.onBack(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveWidth(14),
                          vertical: context.responsiveHeight(8),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.primary, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: context.screenHeight*0.02,),
                    const StepHeadline(
                      title: 'Verify your email',
                      description: "We've sent a verification code to your email",
                      alignment: TextAlign.center,
                    ),

                    SizedBox(height: context.responsiveHeight(40)),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Email (read-only display) ──────────────
                          const SectionLabel('Email Address'),
                          SizedBox(height: context.responsiveHeight(10)),
                          _ReadOnlyEmailDisplay(email: email),

                          SizedBox(height: context.responsiveHeight(40)),

                          // ── OTP section ───────────────────────────────
                          OtpSection(
                            length: 6,
                            onCompleted: (code) =>
                                setState(() => _otpCode = code),
                            onChanged: (code) =>
                                setState(() => _otpCode = code),
                            isResending: _isResending,
                            onResendTap: _handleResend,
                          ),

                          SizedBox(height: context.responsiveHeight(30)),

                          // Verify button
                          PrimaryButton(
                            label: 'Verify & Continue',
                            isLoading: widget.isLoading,
                            onTap: _canVerify ? _handleVerify : null,
                          ),
                        ],
                      ),
                    

                    SizedBox(height: context.responsiveHeight(16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Read-only email display ─────────────────────────────────────────────────

/// Displays the email captured in Step 1 as a styled read-only row.
class _ReadOnlyEmailDisplay extends StatelessWidget {
  const _ReadOnlyEmailDisplay({required this.email});

  /// Email address string.
  final String email;

  @override
  Widget build(BuildContext context) {
    final fill = AppColors.inputFill;
    final border = AppColors.inputBorder;
    const radius = 14.0;
    final height = context.responsiveHeight(52);

    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveWidth(16),
      ),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border, width: 1.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.email_outlined,
            size: context.responsiveFontSize(20),
            color: AppColors.textSecondary,
          ),
          SizedBox(width: context.responsiveWidth(12)),
          Expanded(
            child: Text(
              email.isEmpty ? '—' : email,
              style: TextStyle(
                fontFamily: AppAssets.montserrat,
                fontSize: context.responsiveFontSize(15),
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
