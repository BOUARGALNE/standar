import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_assets.dart';
import '../../extensions/context_extensions.dart';
import '../../theme/app_colors.dart';

/// A simple button widget with customizable style (filled, outline, or text).
///
/// Can display text with an optional leading icon (SVG or widget).
/// Commonly used for social login buttons or secondary actions.
class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.horizontalPadding = 20,
    this.isLoading = false,
    this.isEnabled = true,
    this.prefixIconPath,
    this.iconColor = AppColors.white,
    this.prefixIcon,
    this.iconSize = 22,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.isFilled = false,
  });

  /// The text displayed on the button.
  final String text;

  /// Callback triggered when the button is pressed.
  final VoidCallback? onPressed;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// Whether the button is enabled.
  final bool isEnabled;

  /// Path to an SVG icon to display before the text.
  final String? prefixIconPath;

  /// Custom widget icon to display before the text (takes precedence over prefixIconPath).
  final Widget? prefixIcon;
  final double iconSize;
  final Color iconColor;

  /// Optional fixed width for the button. Defaults to full width.
  final double? width;

  /// Height of the button. Defaults to responsive 56.
  final double? height;

  /// Border radius of the button. Defaults to responsive 30 (pill shape).
  final double? borderRadius;

  /// Background color (for filled buttons).
  final Color? backgroundColor;

  /// Border color (for outline buttons).
  final Color? borderColor;

  /// Text color.
  final Color? textColor;

  /// Font size.
  final double? fontSize;

  /// Font weight.
  final FontWeight? fontWeight;

  final double horizontalPadding;

  /// Whether the button has a filled background.
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    // Responsive dimensions
    final responsiveHeight = height ?? context.responsiveHeight(50);
    final responsiveBorderRadius = borderRadius ?? context.responsiveRadius(50);
    final responsiveFontSize = fontSize ?? context.responsiveFontSize(15);
    final responsiveIconSize = context.responsiveFontSize(iconSize);
    final responsiveLoaderSize = context.responsiveWidth(24);
    final responsiveHorizontalPadding = context.responsiveWidth(
      horizontalPadding,
    );
    final responsiveIconSpacing = context.responsiveWidth(12);

    final bgColor = isFilled
        ? (backgroundColor ?? AppColors.primary)
        : Colors.transparent;
    final fgColor = textColor ?? (isFilled ? AppColors.white : AppColors.black);
    final border = Border.all(
            color: borderColor ?? AppColors.inputBorder,
            width: 1,
          );

    return GestureDetector(
      onTap: isEnabled && !isLoading ? onPressed : null,
      child: Container(
        width: width ?? double.infinity,
        height: responsiveHeight,
        decoration: BoxDecoration(
          color: isEnabled ? bgColor : bgColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(responsiveBorderRadius),
          border: border,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: responsiveLoaderSize,
                  height: responsiveLoaderSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveHorizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Prefix Icon
                    if (prefixIcon != null) ...[
                      prefixIcon!,
                      SizedBox(width: responsiveIconSpacing),
                    ] else if (prefixIconPath != null) ...[
                      SvgPicture.asset(
                        prefixIconPath!,
                        width: responsiveIconSize,
                        height: responsiveIconSize,
                        colorFilter: ColorFilter.mode(
                          iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: responsiveIconSpacing),
                    ],
                    // Text
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: responsiveFontSize,
                        fontWeight: fontWeight ?? FontWeight.w700,
                        fontFamily: AppAssets.lunasima,
                        color: isEnabled
                            ? fgColor
                            : fgColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
