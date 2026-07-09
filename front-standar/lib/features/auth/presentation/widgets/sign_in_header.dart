import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';


/// Header section of the Sign In screen.
///
/// Displays the app title bar and the "Welcome Back." headline
/// with a supporting description.
class SignInHeader extends StatelessWidget {
  const SignInHeader({
    super.key,
    this.title = 'Welcome',
    this.boldPart = 'Back.',
    this.description = 'Log in to download, manage and\nprocess videos from any URL.',
   });

  final String title;
  final String boldPart;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── Main headline ─────────────────────────────────────────────
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$title\n',
                style: TextStyle(
                  fontFamily: AppAssets.urbanist,
                  fontSize: context.responsiveFontSize(38),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              TextSpan(
                text: boldPart,
                style: TextStyle(
                  fontFamily: AppAssets.urbanist,
                  fontSize: context.responsiveFontSize(38),
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  height: 1.1,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: context.responsiveHeight(14)),

        // ── Description ───────────────────────────────────────────────
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppAssets.montserrat,
            fontSize: context.responsiveFontSize(13),
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
