import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';


/// "Or continue with" social login section for the Sign In screen.
///
/// Displays a divider row and two outline buttons for Google and Apple.
class SignInSocialSection extends StatelessWidget {
  const SignInSocialSection({
    super.key,
    this.onGoogleTap,
    this.onAppleTap,
    this.isLoading = false,
  });

  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Divider row ───────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColors.textHint,
                thickness: 1,
                endIndent: 12,
              ),
            ),
            Text(
              'Or continue with',
              style: TextStyle(
                fontSize: context.responsiveFontSize(12),
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                fontFamily: AppAssets.montserrat,
              ),
            ),
            Expanded(
              child: Divider(
                color: AppColors.textHint,
                thickness: 1,
                indent: 12,
              ),
            ),
          ],
        ),

        SizedBox(height: context.responsiveHeight(18)),

        // ── Social buttons row ────────────────────────────────────────
        Row(
          children: [
            // Google button
            Expanded(
              child: _SocialButton(
                label: 'Google',
                icon: SvgPicture.asset(AppAssets.gmailIcon, height: 18),
                onTap: isLoading ? null : onGoogleTap,
              ),
            ),
/*            SizedBox(width: context.responsiveWidth(16)),
            // Apple button
            Expanded(
              child: _SocialButton(
                label: 'Apple',
                icon: Icon(
                  Icons.apple_rounded,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
                onTap: isLoading ? null : onAppleTap,
              ),
            ),*/
          ],
        ),
      ],
    );
  }
}

/// A single social login outline button.
class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, required this.icon, this.onTap});

  final String label;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.inputBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: context.responsiveWidth(30)),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontSize(14),
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: AppAssets.montserrat,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
