import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants/app_assets.dart';
import '../../theme/app_colors.dart';
import '../../extensions/context_extensions.dart';

/// OTP (One-Time Password) input widget with customizable number of fields.
///
/// Features:
/// - Auto-focus next field on input
/// - Auto-focus previous field on delete
/// - Customizable number of digits
/// - Callback when code is complete
class OtpInput extends StatefulWidget {
  const OtpInput({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.fieldWidth,
    this.fieldHeight,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.filledBorderColor,
    this.backgroundColor,
    this.textStyle,
  });

  /// Number of OTP digits. Defaults to 4.
  final int length;

  /// Callback when all fields are filled.
  final ValueChanged<String>? onCompleted;

  /// Callback when any field changes.
  final ValueChanged<String>? onChanged;

  /// Width of each field. Defaults to responsive 60.
  final double? fieldWidth;

  /// Height of each field. Defaults to responsive 60.
  final double? fieldHeight;

  /// Border radius of each field. Defaults to responsive 12.
  final double? borderRadius;

  /// Border color when empty. Defaults to grey.
  final Color? borderColor;

  /// Border color when focused. Defaults to primary.
  final Color? focusedBorderColor;

  /// Border color when filled. Defaults to primary.
  final Color? filledBorderColor;

  /// Background color of fields. Defaults to white.
  final Color? backgroundColor;

  /// Text style for the digits.
  final TextStyle? textStyle;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String get _currentCode {
    return _controllers.map((c) => c.text).join();
  }

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < widget.length - 1) {
      // Move to next field
      _focusNodes[index + 1].requestFocus();
    }

    final code = _currentCode;
    widget.onChanged?.call(code);

    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  void _onKeyDown(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controllers[index].text.isEmpty && index > 0) {
          // Move to previous field and clear it
          _focusNodes[index - 1].requestFocus();
          _controllers[index - 1].clear();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveFieldHeight =
        widget.fieldHeight ?? context.responsiveHeight(45);
    final responsiveBorderRadius =
        widget.borderRadius ?? context.responsiveRadius(12);
    final responsiveFontSize = context.responsiveFontSize(16);

    final spacing = context.responsiveWidth(6);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        final controller = _controllers[index];
        final focusNode = _focusNodes[index];
        final isFilled = controller.text.isNotEmpty;
        final isFocused = focusNode.hasFocus;

        Color borderColor;
        if (isFilled) {
          borderColor = widget.filledBorderColor ?? AppColors.primary;
        } else if (isFocused) {
          borderColor = widget.focusedBorderColor ?? AppColors.primary;
        } else {
          borderColor = widget.borderColor ?? Colors.grey.shade300;
        }

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : spacing / 2,
              right: index == widget.length - 1 ? 0 : spacing / 2,
            ),
            height: responsiveFieldHeight,
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) => _onKeyDown(index, event),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style:
                    widget.textStyle ??
                    TextStyle(
                      fontSize: responsiveFontSize,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppAssets.montserrat,
                      color: AppColors.black,
                    ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.responsiveHeight(10),
                  ),
                  fillColor: widget.backgroundColor ?? AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(responsiveBorderRadius),
                    borderSide: BorderSide(color: borderColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(responsiveBorderRadius),
                    borderSide: BorderSide(color: borderColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(responsiveBorderRadius),
                    borderSide: BorderSide(
                      color: widget.focusedBorderColor ?? AppColors.primary,
                      width: 1,
                    ),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => _onChanged(index, value),
              ),
            ),
          ),
        );
      }),
    );
  }
}
