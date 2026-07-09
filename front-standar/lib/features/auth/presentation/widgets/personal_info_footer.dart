import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';


/// "Already a member? Sign In" footer link for [PersonalInfoStep].
class PersonalInfoFooter extends StatelessWidget {
  const PersonalInfoFooter({super.key, required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: AppAssets.montserrat,
            fontSize: context.responsiveFontSize(14),
          ),
          children: [
            TextSpan(
              text: 'Already a member? ',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: GestureDetector(
                onTap: onSignIn,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: AppAssets.montserrat,
                    fontSize: context.responsiveFontSize(14),
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
