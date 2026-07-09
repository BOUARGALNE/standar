import 'package:flutter/material.dart';

/// Design reference dimensions (iPhone X / 375x812).
const double _designWidth = 375.0;
const double _designHeight = 812.0;

/// Extension on [BuildContext] for convenient access to common properties.
extension ContextExtensions on BuildContext {
  /// Returns the [MediaQueryData] for the current context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the screen size.
  Size get screenSize => mediaQuery.size;

  /// Returns the screen width.
  double get screenWidth => screenSize.width;

  /// Returns the screen height.
  double get screenHeight => screenSize.height;

  /// Returns the device pixel ratio.
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Returns the top padding (e.g., status bar height).
  double get topPadding => mediaQuery.padding.top;

  /// Returns the bottom padding (e.g., navigation bar height).
  double get bottomPadding => mediaQuery.padding.bottom;

  /// Returns the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Returns the current [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Returns the current [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns true if the current theme is dark mode.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // ─────────────────────────────────────────────────────────────────────────
  // Responsive utilities
  // ─────────────────────────────────────────────────────────────────────────

  /// Scale factor based on width (for horizontal dimensions).
  double get scaleWidth => screenWidth / _designWidth;

  /// Scale factor based on height (for vertical dimensions).
  double get scaleHeight => screenHeight / _designHeight;

  /// Returns a responsive width based on the design width (375).
  /// Use for horizontal padding, margins, widths.
  double responsiveWidth(double size) => size * scaleWidth;

  /// Returns a responsive height based on the design height (812).
  /// Use for vertical padding, margins, heights.
  double responsiveHeight(double size) => size * scaleHeight;

  /// Returns a responsive font size.
  /// Uses width scale with a minimum scale factor to prevent text from being too small.
  double responsiveFontSize(double size) {
    final scale = scaleWidth.clamp(0.8, 1.2);
    return size * scale;
  }

  /// Returns a responsive radius.
  double responsiveRadius(double radius) => radius * scaleWidth;

  /// Returns responsive symmetric padding.
  EdgeInsets responsivePadding({double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(
      horizontal: responsiveWidth(horizontal),
      vertical: responsiveHeight(vertical),
    );
  }

  /// Returns responsive EdgeInsets.
  EdgeInsets responsiveEdgeInsets({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: responsiveWidth(left),
      top: responsiveHeight(top),
      right: responsiveWidth(right),
      bottom: responsiveHeight(bottom),
    );
  }
}
