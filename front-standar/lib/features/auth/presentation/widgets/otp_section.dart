import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/atoms/inputs/otp_input.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/organisms/step_headline.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';

/// OTP verification code section used in [PhoneVerificationStep].
///
/// Shows the "VERIFICATION CODE" label, "Resend code" link, and the 6 OTP boxes.
class OtpSection extends StatelessWidget {
  const OtpSection({
    super.key,
    required this.onCompleted,
    required this.onChanged,
    required this.onResendTap,
    this.isResending = false,
    this.length = 6,
  });

  final ValueChanged<String> onCompleted;
  final ValueChanged<String> onChanged;
  final Future<void> Function() onResendTap;
  final bool isResending;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row with "Resend code" link
        SectionLabel(
          'Verification Code',
          trailing: GestureDetector(
            onTap: isResending ? null : onResendTap,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isResending ? 0.5 : 1.0,
              child: Text(
                isResending ? 'Sending...' : 'Resend code',
                style: TextStyle(
                  fontSize: context.responsiveFontSize(12),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  fontFamily: AppAssets.montserrat,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: context.responsiveHeight(20)),

        // OTP boxes
        OtpInput(
          length: length,
          onCompleted: onCompleted,
          onChanged: onChanged,
          fieldWidth: context.responsiveWidth(50),
          fieldHeight: context.responsiveHeight(56),
          borderRadius: 16,
          backgroundColor: AppColors.inputFill,
          borderColor: AppColors.inputBorder,
          focusedBorderColor: AppColors.primary,
          filledBorderColor: AppColors.primary,
        ),
      ],
    );
  }
}
