import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extensions/context_extensions.dart';
import '../../theme/app_colors.dart';

/// A modern text field widget for the Velvet Pulse design system.
///
/// Features:
/// - Optional static label displayed above the field
/// - Animated focus border with primary color
/// - Password visibility toggle
/// - Validation support with styled error messages
/// - Optional prefix/suffix icons using Material Icons
/// - Fully responsive dimensions
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor = AppColors.textHint,
    this.iconSize = 20.0,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
    this.autocorrect = true,
    this.fillColor = AppColors.inputFill,
    this.borderColor = AppColors.inputBorder,
    this.focusedBorderColor = AppColors.inputBorderFocused,
    this.errorBorderColor = AppColors.red,
    this.borderRadius,
    this.contentPadding,
    this.fontSize,
    this.labelFontSize,
    this.errorTextStyle,
    // Legacy SVG support — kept for backward compatibility
    this.prefixIconPath,
    this.suffixIconPath,
    this.labelBackgroundColor = AppColors.primary,
  });

  /// Controller for the text field.
  final TextEditingController? controller;

  /// Static label displayed above the field.
  final String? label;

  /// Hint text displayed inside the field when empty.
  final String? hintText;

  /// Material icon for the prefix (leading) position.
  final IconData? prefixIcon;

  /// Material icon for the suffix (trailing) position (ignored when obscureText=true).
  final IconData? suffixIcon;

  /// Color for prefix/suffix icons.
  final Color iconColor;

  /// Size for prefix/suffix icons.
  final double iconSize;

  /// Whether to obscure the text (password mode).
  final bool obscureText;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Maximum number of lines.
  final int maxLines;

  /// Minimum number of lines.
  final int? minLines;

  /// Maximum character length.
  final int? maxLength;

  /// Type of keyboard to display.
  final TextInputType? keyboardType;

  /// Action button on the keyboard.
  final TextInputAction? textInputAction;

  /// Input formatters to apply.
  final List<TextInputFormatter>? inputFormatters;

  /// Validation function.
  final String? Function(String?)? validator;

  /// Callback when text changes.
  final ValueChanged<String>? onChanged;

  /// Callback when user submits.
  final ValueChanged<String>? onSubmitted;

  /// Callback when field is tapped.
  final VoidCallback? onTap;

  /// Focus node for the field.
  final FocusNode? focusNode;

  /// Whether to autofocus this field.
  final bool autofocus;

  /// Whether to enable autocorrect.
  final bool autocorrect;

  /// Background fill color.
  final Color fillColor;

  /// Border color when not focused.
  final Color borderColor;

  /// Border color when focused.
  final Color focusedBorderColor;

  /// Border color when there's a validation error.
  final Color errorBorderColor;

  /// Border radius. Defaults to 14.
  final double? borderRadius;

  /// Padding inside the field.
  final EdgeInsetsGeometry? contentPadding;

  /// Font size for the input text.
  final double? fontSize;

  /// Font size for the label text.
  final double? labelFontSize;

  /// Custom style for error text.
  final TextStyle? errorTextStyle;

  // ---- Legacy SVG props (kept for backward compat, not rendered) ----
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Color labelBackgroundColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscured = false;

  late AnimationController _borderAnimation;
  late Animation<double> _borderWidth;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller?.addListener(_rebuild);

    _borderAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _borderWidth = Tween<double>(begin: 1.0, end: 1.8).animate(
      CurvedAnimation(parent: _borderAnimation, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_rebuild);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    _borderAnimation.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_isFocused) {
      _borderAnimation.forward();
    } else {
      _borderAnimation.reverse();
    }
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? 14.0;
    final hPad = context.responsiveWidth(12);
    final vPad = context.responsiveHeight(12);

    final activeBorderColor =
        _isFocused ? widget.focusedBorderColor : widget.borderColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Static label above the field ──────────────────────────────
        if (widget.label != null) ...[
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: TextStyle(
              fontSize: widget.labelFontSize ?? context.responsiveFontSize(12),
              fontWeight: FontWeight.w600,
              color: _isFocused
                  ? widget.focusedBorderColor
                  : AppColors.textSecondary,
              letterSpacing: 0.4,
            ),
            child: Text(widget.label!),
          ),
          SizedBox(height: context.responsiveHeight(6)),
        ],

        // ── Text Field ────────────────────────────────────────────────
        AnimatedBuilder(
          animation: _borderWidth,
          builder: (context, child) {
            return TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: _isObscured,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              maxLines: widget.obscureText ? 1 : widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              inputFormatters: widget.inputFormatters,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
              onTap: widget.onTap,
              autofocus: widget.autofocus,
              autocorrect: widget.autocorrect,
              style: TextStyle(
                fontSize: widget.fontSize ?? context.responsiveFontSize(14),
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: AppColors.textHint,
                  fontSize: widget.fontSize ?? context.responsiveFontSize(14),
                  fontWeight: FontWeight.w400,
                ),
                counterText: '',
                errorStyle: (widget.errorTextStyle ??
                    TextStyle(
                      fontSize: context.responsiveFontSize(11),
                      color: AppColors.red,
                      fontWeight: FontWeight.w500,
                    )),
                errorMaxLines: 2,
                filled: true,
                fillColor: widget.enabled
                    ? widget.fillColor
                    : AppColors.inputFill.withValues(alpha: 0.5),

                // ── Prefix icon ────────────────────────────────────
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: _isFocused
                            ? widget.focusedBorderColor
                            : widget.iconColor,
                        size: widget.iconSize,
                      )
                    : null,

                // ── Suffix icon / password toggle ──────────────────
                suffixIcon: widget.obscureText
                    ? IconButton(
                        icon: Icon(
                          _isObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _isFocused
                              ? widget.focusedBorderColor
                              : widget.iconColor,
                          size: widget.iconSize,
                        ),
                        onPressed: () {
                          setState(() => _isObscured = !_isObscured);
                        },
                      )
                    : widget.suffixIcon != null
                        ? Icon(
                            widget.suffixIcon,
                            color: _isFocused
                                ? widget.focusedBorderColor
                                : widget.iconColor,
                            size: widget.iconSize,
                          )
                        : null,

                contentPadding: widget.contentPadding ??
                    EdgeInsets.symmetric(
                      horizontal: hPad,
                      vertical: vPad,
                    ),

                // ── Borders ────────────────────────────────────────
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(
                    color: activeBorderColor,
                    width: _borderWidth.value,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(
                    color: widget.borderColor,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor,
                    width: _borderWidth.value,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(
                    color: widget.errorBorderColor,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(
                    color: widget.errorBorderColor,
                    width: 1.8,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide(
                    color: widget.borderColor.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
