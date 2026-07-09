import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_assets.dart';
import '../../extensions/context_extensions.dart';
import '../../theme/app_colors.dart';

/// A text button with underline decoration and no background.
///
/// Used for links like "Mot de passe oublié ?" or "S'inscrire".
class UnderlineButton extends StatelessWidget {
  const UnderlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIconPath,
    this.suffixIconPath,
    this.iconSize = 16,
    this.iconSpacing = 6,
    this.textColor = AppColors.black,
    this.underlineColor,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.isEnabled = true,
    this.isUnderline = true,
  });

  /// The text displayed on the button.
  final String text;

  /// Callback triggered when the button is pressed.
  final VoidCallback? onPressed;

  /// Path to SVG icon displayed before the text.
  final String? prefixIconPath;
  final String? suffixIconPath;

  /// Size of the prefix icon.
  final double iconSize;

  /// Spacing between icon and text.
  final double iconSpacing;

  /// Color of the text.
  final Color textColor;

  /// Color of the underline. Defaults to textColor if not specified.
  final Color? underlineColor;

  /// Font size of the text.
  final double? fontSize;

  /// Font weight of the text.
  final FontWeight fontWeight;

  /// text with underline or not.
  final bool isUnderline;

  /// Whether the button is enabled.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = fontSize ?? context.responsiveFontSize(14);
    final responsiveIconSize = context.responsiveWidth(iconSize);
    final responsiveIconSpacing = context.responsiveWidth(iconSpacing);
    final effectiveColor = isEnabled
        ? textColor
        : textColor.withValues(alpha: 0.5);
    final effectiveUnderlineColor = underlineColor ?? effectiveColor;

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: prefixIconPath != null || suffixIconPath != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                prefixIconPath != null
                    ? SvgPicture.asset(
                        prefixIconPath!,
                        width: responsiveIconSize,
                        height: responsiveIconSize,
                        colorFilter: ColorFilter.mode(
                          effectiveColor,
                          BlendMode.srcIn,
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(width: responsiveIconSpacing),
                Text(
                  text,
                  style: TextStyle(
                    color: effectiveColor,
                    fontSize: responsiveFontSize,
                    fontWeight: fontWeight,
                    fontFamily: AppAssets.montserrat,
                    decoration: isUnderline
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: effectiveUnderlineColor,
                    decorationThickness: 1,
                  ),
                ),
                SizedBox(width: responsiveIconSpacing),
                suffixIconPath != null
                    ? SvgPicture.asset(
                        suffixIconPath!,
                        width: responsiveIconSize,
                        height: responsiveIconSize,
                        colorFilter: ColorFilter.mode(
                          effectiveColor,
                          BlendMode.srcIn,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: effectiveColor,
                fontSize: responsiveFontSize,
                fontWeight: fontWeight,
                fontFamily: AppAssets.montserrat,
                decoration: isUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: effectiveUnderlineColor,
                decorationThickness: 1,
              ),
            ),
    );
  }
}
