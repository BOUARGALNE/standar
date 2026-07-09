import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../constants/app_assets.dart';
import '../extensions/context_extensions.dart';

/// Large section headline with an optional accent-colored part.
///
/// Commonly used at the top of wizard steps, onboarding screens,
/// and modal sheets to display a primary title + description.
///
/// Example:
/// ```dart
/// StepHeadline(
///   title: 'Join the ',
///   accentPart: 'Pulse.',
///   description: 'Create an account to start...',
/// )
/// ```
class StepHeadline extends StatelessWidget {
  const StepHeadline({
    super.key,
    required this.title,
    this.accentPart,
    this.description,
    this.alignment = TextAlign.center,
    this.titleFontSize,
    this.descriptionFontSize,
  });

  /// First part of the headline (dark color).
  final String title;

  /// Highlighted part appended after [title] (primary color).
  final String? accentPart;

  /// Optional subtitle below the headline.
  final String? description;

  /// Text alignment for both headline and description.
  final TextAlign alignment;

  /// Override for title font size.
  final double? titleFontSize;

  /// Override for description font size.
  final double? descriptionFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Headline
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  fontFamily: AppAssets.urbanist,
                  fontSize: titleFontSize ?? context.responsiveFontSize(34),
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
              ),
              if (accentPart != null)
                TextSpan(
                  text: accentPart,
                  style: TextStyle(
                    fontFamily: AppAssets.urbanist,
                    fontSize: titleFontSize ?? context.responsiveFontSize(34),
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    height: 1.15,
                  ),
                ),
            ],
          ),
          textAlign: alignment,
        ),

        if (description != null) ...[
          SizedBox(height: context.responsiveHeight(10)),
          Text(
            description!,
            textAlign: alignment,
            style: TextStyle(
              fontFamily: AppAssets.montserrat,
              fontSize: descriptionFontSize ?? context.responsiveFontSize(13),
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ],
    );
  }
}

/// A simple label for a form section, with an optional trailing widget.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: AppAssets.montserrat,
            fontSize: context.responsiveFontSize(14),
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
