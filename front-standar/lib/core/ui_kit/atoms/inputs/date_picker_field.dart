import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_assets.dart';
import '../../theme/app_colors.dart';
import '../../extensions/context_extensions.dart';

/// A date picker field that looks like a text input but opens a date picker on tap.
class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    this.label,
    this.hintText = 'mm/dd/yyyy',
    this.initialDate,
    this.onDateSelected,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 14.0,
    this.bottomHint,
  });

  final String? label;
  final String hintText;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSelected;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final String? bottomHint;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textOnPrimary,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fill = widget.fillColor ?? AppColors.inputFill;
    final border = widget.borderColor ?? AppColors.inputBorder;
    final radius = widget.borderRadius;
    final height = context.responsiveHeight(54);

    final displayFormat = DateFormat('MM/dd/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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

        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            height: height,
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveWidth(16),
            ),
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: border, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? displayFormat.format(_selectedDate!)
                      : widget.hintText,
                  style: TextStyle(
                    fontFamily: AppAssets.montserrat,
                    fontSize: context.responsiveFontSize(15),
                    fontWeight: FontWeight.w500,
                    color: _selectedDate != null
                        ? AppColors.textPrimary
                        : AppColors.textHint,
                  ),
                ),
                Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.textPrimary,
                  size: context.responsiveFontSize(20),
                ),
              ],
            ),
          ),
        ),
        
        if (widget.bottomHint != null) ...[
           SizedBox(height: context.responsiveHeight(6)),
           Text(
            widget.bottomHint!,
            style: TextStyle(
              fontFamily: AppAssets.montserrat,
              fontSize: context.responsiveFontSize(11),
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}
