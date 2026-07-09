import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/atoms/buttons/simple_button.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';

/// Shows a generic confirmation dialog.
/// 
/// Returns `true` if the user confirmed, `false` or `null` if cancelled/dismissed.
Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
  Color confirmTextColor = AppColors.white,
  Color confirmBackgroundColor = AppColors.primary,
  bool isDestructive = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppAssets.montserrat,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: SimpleButton(
                      text: cancelText,
                      textColor: AppColors.textPrimary,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.textHint.withValues(alpha: 0.3),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SimpleButton(
                      text: confirmText,
                      isFilled: true,
                      textColor: isDestructive ? AppColors.white : confirmTextColor,
                      backgroundColor: isDestructive ? AppColors.red : confirmBackgroundColor,
                      borderColor: Colors.transparent,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
