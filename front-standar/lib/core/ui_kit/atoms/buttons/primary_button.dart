import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// A primary action button for the Velvet Pulse design system.
///
/// Features:
/// - Gradient background (primary → primaryGradientEnd)
/// - Optional loading state with spinner
/// - Optional leading icon
/// - Subtle drop shadow for depth
/// - Fully rounded pill shape
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.icon,
    this.suffixIcon,
    this.gradient,
    this.backgroundColor,
    this.foregroundColor = AppColors.textOnPrimary,
    this.borderColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.height = 58,
    this.borderRadius = 32,
  });

  /// Button label text.
  final String label;

  /// Tap callback. Pass null to disable the button.
  final VoidCallback? onTap;

  /// Whether to show a loading spinner instead of the label.
  final bool isLoading;

  /// Optional leading icon displayed before the label.
  final Widget? icon;

  /// Optional trailing icon displayed after the label.
  final Widget? suffixIcon;

  /// Custom gradient. Defaults to AppColors.primaryGradient.
  final Gradient? gradient;

  /// Solid background color (used only when [gradient] is null).
  final Color? backgroundColor;

  /// Text and icon color.
  final Color foregroundColor;

  /// Optional border color.
  final Color? borderColor;

  /// Font size for the label.
  final double fontSize;

  /// Font weight for the label.
  final FontWeight fontWeight;

  /// Height of the button.
  final double height;

  /// Border radius of the button.
  final double borderRadius;

  bool get _isDisabled => onTap == null || isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ??
        (backgroundColor == null ? AppColors.primaryGradient : null);

    return GestureDetector(
      onTap: _isDisabled ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _isDisabled ? 0.6 : 1.0,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: effectiveGradient == null ? backgroundColor : null,
            gradient: effectiveGradient,
            borderRadius: BorderRadius.circular(borderRadius),
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 1.5)
                : null,
            boxShadow: _isDisabled
                ? null
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 16,
                      spreadRadius: 0,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isLoading
                    ? SizedBox(
                        key: const ValueKey('loader'),
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(foregroundColor),
                        ),
                      )
                    : Row(
                        key: const ValueKey('content'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            icon!,
                            const SizedBox(width: 10),
                          ],
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              color: foregroundColor,
                              letterSpacing: 0.3,
                            ),
                          ),
                          if (suffixIcon != null) ...[
                            const SizedBox(width: 10),
                            suffixIcon!,
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}