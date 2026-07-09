import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../extensions/context_extensions.dart';

/// A dialog container commonly used for authf screens.
///
/// Features:
/// - Positioned at the bottom of the screen
/// - Rounded top corners
/// - Customizable height percentage
/// - Optional border
class AuthDialog extends StatelessWidget {
  const AuthDialog({
    super.key,
    required this.child,
    this.heightPercentage = 0.75,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.showBorder = true,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });

  /// The content widget to display inside the dialog.
  final Widget child;

  /// Height as a percentage of screen height (0.0 to 1.0).
  final double heightPercentage;

  /// Outer padding around the dialog container.
  final EdgeInsets padding;

  /// Whether to show a border around the dialog.
  final bool showBorder;

  /// Color of the border. Defaults to primary color.
  final Color? borderColor;

  /// Background color of the dialog. Defaults to white.
  final Color? backgroundColor;

  /// Border radius for top corners. Defaults to responsive 30.
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final responsiveBorderRadius = borderRadius ?? context.responsiveRadius(30);
    final bgColor = backgroundColor ?? AppColors.white;
    final border = showBorder
        ? Border.all(color: borderColor ?? AppColors.secondary, width: 1.0)
        : null;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: padding,
        child: Container(
          height: context.screenHeight * heightPercentage,
          width: double.infinity,
          decoration: BoxDecoration(
            color: bgColor,
            border: border,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(responsiveBorderRadius),
              topRight: Radius.circular(responsiveBorderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(context.responsiveWidth(24)),
            child: child,
          ),
        ),
      ),
    );
  }
}
