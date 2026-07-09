import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extensions/context_extensions.dart';
import '../../theme/app_colors.dart';

/// A custom dropdown field widget following the Control One design system.
///
/// Features:
/// - Floating label with background when focused or has value
/// - Optional prefix icon (SVG)
/// - Dropdown arrow suffix
/// - Custom styling with rounded borders
/// - Responsive dimensions based on screen size
class CustomDropdownField<T> extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hintText,
    this.prefixIconPath,
    this.iconColor = AppColors.primary,
    this.iconSize = 12,
    this.enabled = true,
    this.fillColor = AppColors.primaryLight2,
    this.borderColor = AppColors.primary,
    this.focusedBorderColor = AppColors.primary,
    this.borderRadius,
    this.contentPadding,
    this.fontSize,
    this.labelFontSize,
    this.labelBackgroundColor = AppColors.secondary,
    this.itemBuilder,
    this.selectedItemBuilder,
    this.validator,
    this.autovalidateMode,
  });

  /// List of dropdown items.
  final List<DropdownMenuItem<T>> items;

  /// Callback when selection changes.
  final ValueChanged<T?> onChanged;

  /// Currently selected value.
  final T? value;

  /// Label text displayed above the field.
  final String? label;

  /// Hint text displayed when no value is selected.
  final String? hintText;

  /// Path to SVG icon displayed at the start of the field.
  final String? prefixIconPath;

  /// Color for the prefix icon.
  final Color iconColor;

  /// Size for the prefix icon.
  final double iconSize;

  /// Whether the dropdown is enabled.
  final bool enabled;

  /// Background fill color.
  final Color? fillColor;

  /// Border color when not focused.
  final Color? borderColor;

  /// Border color when focused.
  final Color? focusedBorderColor;

  /// Border radius of the field.
  final double? borderRadius;

  /// Padding inside the field.
  final EdgeInsetsGeometry? contentPadding;

  /// Font size for the selected text.
  final double? fontSize;

  /// Font size for the label text.
  final double? labelFontSize;

  /// Background color for the floating label.
  final Color labelBackgroundColor;

  /// Custom builder for dropdown items.
  final Widget Function(T)? itemBuilder;

  /// Custom builder for selected item display.
  final Widget Function(T)? selectedItemBuilder;

  /// Validator callback.
  final String? Function(T?)? validator;

  /// Autovalidate mode.
  final AutovalidateMode? autovalidateMode;

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  bool _isFocused = false;

  bool get _hasValue => widget.value != null;
  bool get _shouldShowLabelBackground => _isFocused || _hasValue;

  @override
  Widget build(BuildContext context) {
    final responsiveBorderRadius =
        widget.borderRadius ?? context.responsiveRadius(12);
    final responsiveHorizontalPadding = context.responsiveWidth(6);
    final responsiveVerticalPadding = context.responsiveHeight(14);
    final responsiveBorderWidth = context.responsiveWidth(1);

    final defaultBorderColor = widget.borderColor ?? Colors.grey.shade300;
    final bgColor = widget.fillColor ?? Colors.white;

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: DropdownButtonFormField<T>(
        value: widget.value,
        items: widget.items,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        onChanged: widget.enabled ? widget.onChanged : null,
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 26,
          //colorFilter: ColorFilter.mode(widget.iconColor, BlendMode.srcIn),
        ),
        iconSize: context.responsiveWidth(18),
        isExpanded: true,
        dropdownColor: AppColors.white,
        focusColor: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(context.responsiveRadius(16)),
        menuMaxHeight: context.responsiveHeight(300),
        elevation: 8,
        style: TextStyle(
          color: AppColors.secondary,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            inherit: false,
            fontSize: context.responsiveFontSize(10),
            color: Colors.red,
            overflow: TextOverflow.visible,
          ),
          errorMaxLines: 3,
          label: widget.label != null
              ? Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _shouldShowLabelBackground
                        ? context.responsiveWidth(8)
                        : 0,
                    vertical: _shouldShowLabelBackground
                        ? context.responsiveHeight(2)
                        : 0,
                  ),
                  decoration: _shouldShowLabelBackground
                      ? ShapeDecoration(
                          color: widget.labelBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              context.responsiveRadius(4),
                            ),
                          ),
                        )
                      : null,
                  child: Text(
                    widget.label!,
                    style: TextStyle(
                        fontSize: widget.labelFontSize ??
                            context.responsiveFontSize(12),
                        color: AppColors.secondary)),
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          filled: _shouldShowLabelBackground,
          fillColor: widget.enabled ? bgColor : Colors.grey.shade100,
          prefixIcon: widget.prefixIconPath != null
              ? Padding(
                  padding: EdgeInsets.only(
                    left: context.responsiveWidth(0),
                    top: context.responsiveHeight(13),
                    bottom: context.responsiveHeight(13),
                  ),
                  child: SvgPicture.asset(
                    widget.prefixIconPath!,
                    width: context.responsiveWidth(widget.iconSize),
                    height: context.responsiveWidth(widget.iconSize),
                    colorFilter: ColorFilter.mode(
                      widget.iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : null,
          contentPadding:
              widget.contentPadding ??
              EdgeInsets.symmetric(
                horizontal: responsiveHorizontalPadding,
                vertical: responsiveVerticalPadding,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveBorderRadius),
            borderSide: BorderSide(
              color: defaultBorderColor,
              width: responsiveBorderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveBorderRadius),
            borderSide: BorderSide(
              color: defaultBorderColor,
              width: responsiveBorderWidth,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveBorderRadius),
            borderSide: BorderSide(
              color: Colors.red,
              width: responsiveBorderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveBorderRadius),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? defaultBorderColor,
              width: responsiveBorderWidth,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsiveBorderRadius),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: responsiveBorderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
