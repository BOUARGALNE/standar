import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';


/// Terms of Service + Privacy Policy animated checkbox row.
///
/// Shows a circular checkbox and inline rich text with tappable links.
class TermsCheckbox extends StatelessWidget {
  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circular checkbox
        GestureDetector(
          onTap: () => onChanged(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? AppColors.primary : AppColors.surface,
              border: Border.all(
                color: value ? AppColors.primary : AppColors.inputBorder,
                width: 1.5,
              ),
              boxShadow: value
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: value
                ? const Icon(
                    Icons.check_rounded,
                    size: 13,
                    color: AppColors.textOnPrimary,
                  )
                : null,
          ),
        ),

        SizedBox(width: context.responsiveWidth(10)),

        // Rich text
        Expanded(
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontFamily: AppAssets.montserrat,
                fontSize: context.responsiveFontSize(12),
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: onTermsTap,
                    child: Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontFamily: AppAssets.montserrat,
                        fontSize: context.responsiveFontSize(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: ' and '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: onPrivacyTap,
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontFamily: AppAssets.montserrat,
                        fontSize: context.responsiveFontSize(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const TextSpan(
                  text: ', including how Velvet Pulse uses my data.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
