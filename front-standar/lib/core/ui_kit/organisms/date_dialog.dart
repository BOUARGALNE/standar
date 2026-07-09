import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import '../theme/app_colors.dart';

/// A customized date picker dialog following the Control One design system.
///
/// This provides a styled date picker with:
/// - Primary blue header
/// - Custom typography using app fonts
/// - Rounded corners and modern styling
/// - Customizable colors and date constraints
class AppDatePicker {
  AppDatePicker._();

  /// Shows a styled date picker dialog.
  ///
  /// Returns the selected [DateTime] or null if cancelled.
  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Color? headerColor,
    Color? accentColor,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    final now = DateTime.now();
    final effectiveInitialDate = initialDate ?? now;
    final effectiveFirstDate = firstDate ?? DateTime(2020);
    final effectiveLastDate = lastDate ?? DateTime(2030);
    final effectiveAccentColor = accentColor ?? AppColors.primary;

    return showDatePicker(
      context: context,
      initialDate: effectiveInitialDate,
      firstDate: effectiveFirstDate,
      lastDate: effectiveLastDate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.secondaryDark,
              onPrimary: AppColors.white,
              secondary: AppColors.primary,
              onSecondary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.secondaryDark,
              surfaceContainerHighest: AppColors.primaryLight,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: AppColors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 14,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              dividerColor: effectiveAccentColor,
              headerBackgroundColor: headerColor ?? effectiveAccentColor,
              headerForegroundColor: AppColors.white,
              headerHeadlineStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                fontFamily: AppAssets.montserrat,
                color: AppColors.white,
              ),
              headerHelpStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: AppAssets.lunasima,
                color: AppColors.white,
              ),
              weekdayStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: AppAssets.montserrat,
                color: effectiveAccentColor,
              ),
              dayStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: AppAssets.montserrat,
                color: AppColors.secondaryDark,
              ),
              todayBackgroundColor: WidgetStatePropertyAll(
                effectiveAccentColor.withAlpha(40),
              ),
              todayForegroundColor: WidgetStatePropertyAll(
                effectiveAccentColor,
              ),
              todayBorder: BorderSide(color: effectiveAccentColor, width: 2),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return effectiveAccentColor;
                }
                if (states.contains(WidgetState.hovered)) {
                  return effectiveAccentColor.withAlpha(20);
                }
                return null;
              }),
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.white;
                }
                return AppColors.secondaryDark;
              }),
              dayOverlayColor: WidgetStatePropertyAll(
                effectiveAccentColor.withAlpha(30),
              ),
              yearStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: AppAssets.montserrat,
              ),
              yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return effectiveAccentColor;
                }
                return null;
              }),
              yearForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.white;
                }
                return AppColors.secondaryDark;
              }),
              yearOverlayColor: WidgetStatePropertyAll(
                effectiveAccentColor.withAlpha(30),
              ),
              rangePickerBackgroundColor: AppColors.white,
              rangeSelectionBackgroundColor: effectiveAccentColor.withAlpha(60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(
                  AppColors.secondaryDark,
                ),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppAssets.lunasima,
                  ),
                ),
              ),
              confirmButtonStyle: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(effectiveAccentColor),
                foregroundColor: WidgetStatePropertyAll(AppColors.white),
                elevation: WidgetStatePropertyAll(4),
                shadowColor: WidgetStatePropertyAll(
                  effectiveAccentColor.withAlpha(100),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppAssets.lunasima,
                  ),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(effectiveAccentColor),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppAssets.lunasima,
                  ),
                ),
              ),
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(effectiveAccentColor),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
