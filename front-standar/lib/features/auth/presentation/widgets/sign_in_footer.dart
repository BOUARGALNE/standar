import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';


/// Footer section at the bottom of the Sign In screen.
///
/// Shows "Don't have an account? Sign Up" with a tappable Sign Up link.
class SignInFooter extends StatelessWidget {
  const SignInFooter({
    super.key,
    required this.onSignUpTap,
    this.isLoading = false,
  });

  final VoidCallback? onSignUpTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: context.responsiveFontSize(14),
            fontFamily: AppAssets.montserrat,
          ),
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: GestureDetector(
                onTap: isLoading ? null : onSignUpTap,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(14),
                    fontFamily: AppAssets.montserrat,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
