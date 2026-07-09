import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';

import '../../../constants/app_assets.dart';
import '../../theme/app_colors.dart';
import '../../extensions/context_extensions.dart';

/// A phone number text field with country code picker.
///
/// Uses the `country_picker` package for selecting country dial codes.
///
/// Features:
/// - Tappable country code pill with flag emoji + dial code
/// - Digits-only phone number input
/// - Read-only mode for displaying a captured phone number
/// - Validation support
/// - Consistent styling with the Velvet Pulse design system
class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText = '555-0123',
    this.initialCountryCode = 'US',
    this.onCountryChanged,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius = 14.0,
  });

  /// Controller for the phone number text field.
  final TextEditingController? controller;

  /// Label displayed above the field.
  final String? label;

  /// Hint text inside the number input.
  final String hintText;

  /// Initial country ISO code (e.g. 'US', 'FR', 'DZ').
  final String initialCountryCode;

  /// Called when the user picks a different country.
  final ValueChanged<Country>? onCountryChanged;

  /// Called when the phone number text changes.
  final ValueChanged<String>? onChanged;

  /// Validation function for the phone number.
  final String? Function(String?)? validator;

  /// Whether the field is enabled.
  final bool enabled;

  /// If true, both the country picker and number are read-only.
  final bool readOnly;

  /// Focus node for the number field.
  final FocusNode? focusNode;

  /// Keyboard action button.
  final TextInputAction textInputAction;

  /// Background fill color. Defaults to [AppColors.inputFill].
  final Color? fillColor;

  /// Border color when not focused. Defaults to [AppColors.inputBorder].
  final Color? borderColor;

  /// Border color when focused. Defaults to [AppColors.inputBorderFocused].
  final Color? focusedBorderColor;

  /// Border radius for both the pill and the input.
  final double borderRadius;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = CountryParser.parseCountryCode(widget.initialCountryCode);
  }

  void _showPicker() {
    if (!widget.enabled || widget.readOnly) return;
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['US', 'FR', 'GB', 'DZ', 'MA', 'TN'],
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        inputDecoration: InputDecoration(
          hintText: 'Search country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.inputBorder),
          ),
        ),
      ),
      onSelect: (country) {
        setState(() => _selectedCountry = country);
        widget.onCountryChanged?.call(country);
      },
    );
  }

  /// Returns the full phone number with dial code: "+1 5550123"
  String get fullNumber =>
      '+${_selectedCountry.phoneCode}${widget.controller?.text.trim() ?? ''}';

  @override
  Widget build(BuildContext context) {
    final fill = widget.fillColor ?? AppColors.inputFill;
    final border = widget.borderColor ?? AppColors.inputBorder;
    final focusedBorder = widget.focusedBorderColor ?? AppColors.inputBorderFocused;
    final radius = widget.borderRadius;
    final height = context.responsiveHeight(45);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Label ──────────────────────────────────────────────────────
        if (widget.label != null) ...[
          Text(
            widget.label!.toUpperCase(),
            style: TextStyle(
              fontSize: context.responsiveFontSize(12),
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: context.responsiveHeight(6)),
        ],

        // ── Phone row ──────────────────────────────────────────────────
        Row(
          children: [
            // Country code pill
            GestureDetector(
              onTap: _showPicker,
              child: Container(
                height: height,
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveWidth(12),
                ),
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(color: border, width: 1.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedCountry.flagEmoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: context.responsiveWidth(4)),
                    Text(
                      '+${_selectedCountry.phoneCode}',
                      style: TextStyle(
                        fontFamily: AppAssets.montserrat,
                        fontSize: context.responsiveFontSize(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (!widget.readOnly) ...[
                      SizedBox(width: context.responsiveWidth(2)),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(width: context.responsiveWidth(10)),

            // Phone number input
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                keyboardType: TextInputType.phone,
                textInputAction: widget.textInputAction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: widget.validator,
                onChanged: widget.onChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(
                  fontFamily: AppAssets.montserrat,
                  fontSize: context.responsiveFontSize(15),
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: AppColors.textHint,
                    fontFamily: AppAssets.montserrat,
                    fontSize: context.responsiveFontSize(15),
                  ),
                  filled: true,
                  fillColor: fill,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.responsiveWidth(16),
                    vertical: context.responsiveWidth(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(color: border, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(color: border, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(color: focusedBorder, width: 1.8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(color: AppColors.red, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(
                      color: border.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
