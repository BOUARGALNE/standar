import 'package:flutter/material.dart';

import '../../../constants/app_assets.dart';
import '../../extensions/context_extensions.dart';
import '../../theme/app_colors.dart';

/// Map Search Bar Widget
///
/// A search bar for entering city names or postal codes.
class PrimarySearchBar extends StatefulWidget {
  const PrimarySearchBar({
    super.key,
    this.controller,
    this.onSearch,
    this.onChanged,
    this.hintText = 'Code postal, ville',
    this.borderColor = AppColors.secondary,
    this.initialValue,
  });

  /// Text controller for the search field
  final TextEditingController? controller;

  /// Callback when user submits search
  final void Function(String query)? onSearch;

  /// Callback when text changes
  final void Function(String value)? onChanged;

  /// Hint text to display
  final String hintText;

  final Color borderColor;

  /// Initial value
  final String? initialValue;

  @override
  State<PrimarySearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<PrimarySearchBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
      _hasText = widget.initialValue!.isNotEmpty;
    }

    // Listen to focus changes
    _focusNode.addListener(_onFocusChange);

    // Listen to text changes
    _controller.addListener(_onTextChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChange() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_onTextChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Background color changes to primaryLight when focused or has text
  Color get _backgroundColor =>
      (_isFocused || _hasText) ? AppColors.primaryLight2 : AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(context.responsiveRadius(12)),
        border: Border.all(color: widget.borderColor, width: 0.75),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSearch,
        style: TextStyle(
          fontSize: context.responsiveFontSize(14),
          fontFamily: AppAssets.montserrat,
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: context.responsiveFontSize(14),
            fontFamily: AppAssets.lunasima,
            fontWeight: FontWeight.w400,
            color: AppColors.textDescription,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.primary,
            size: context.responsiveFontSize(24),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.responsiveWidth(16),
            vertical: context.responsiveHeight(13),
          ),
        ),
      ),
    );
  }
}
