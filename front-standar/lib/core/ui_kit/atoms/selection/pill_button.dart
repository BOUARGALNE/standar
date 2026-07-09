import 'package:flutter/material.dart';
import '../../../constants/app_assets.dart';
import '../../theme/app_colors.dart';
import '../../extensions/context_extensions.dart';

/// A pill-shaped button for selection, used for gender and interests.
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.isSolidMode = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  /// If true, the pill turns solid primary color when selected.
  /// Used for interest tags like "Techno", "Sushi".
  final bool isSolidMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveWidth(icon != null || isSelected ? 16 : 24),
          vertical: context.responsiveHeight(14),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isSolidMode ? AppColors.primary : AppColors.primary.withValues(alpha: 0.15))
              : AppColors.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected
                ? (isSolidMode ? AppColors.transparent : AppColors.primary.withValues(alpha: 0.3))
                : AppColors.transparent,
            width: 1,
          ),
          boxShadow: isSelected ? [] : [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSolidMode && isSelected) ...[
              Icon(
                Icons.check,
                size: context.responsiveFontSize(16),
                color: AppColors.surface,
              ),
              SizedBox(width: context.responsiveWidth(6)),
            ],
            if (icon != null && (!isSolidMode || !isSelected)) ...[
              Icon(
                icon,
                size: context.responsiveFontSize(18),
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
              SizedBox(width: context.responsiveWidth(8)),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: AppAssets.montserrat,
                fontSize: context.responsiveFontSize(14),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? (isSolidMode ? AppColors.surface : AppColors.primary)
                    : AppColors.textPrimary,
              ),
            ),
            if (!isSolidMode && isSelected) ...[
              SizedBox(width: context.responsiveWidth(6)),
              Icon(
                Icons.check,
                size: context.responsiveFontSize(14),
                color: AppColors.primary,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
