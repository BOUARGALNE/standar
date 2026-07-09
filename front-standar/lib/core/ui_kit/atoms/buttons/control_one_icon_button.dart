import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extensions/context_extensions.dart';
import '../../theme/app_colors.dart';

/// Location Button Widget
///
/// A circular button to center the map on user's current location.
class ControlOneIconButton extends StatelessWidget {
  const ControlOneIconButton({
    super.key,
    required this.onPressed,
    required this.iconPath,
    this.isLoading = false,
    this.size,
    this.backgroundColor,
    this.iconColor,
  });

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Whether to show loading indicator
  final bool isLoading;

  /// Button size
  final double? size;

  /// Background color
  final Color? backgroundColor;

  /// Icon color
  final Color? iconColor;

  /// icon path
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? context.responsiveWidth(50);

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(context.responsiveRadius(12)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: buttonSize * 0.5,
                  height: buttonSize * 0.5,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      iconColor ?? AppColors.white,
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    iconColor ?? AppColors.white,
                    BlendMode.srcIn,
                  ),
                  height: context.responsiveFontSize(12),
                  width: context.responsiveFontSize(12),
                ),
              ),
      ),
    );
  }
}
