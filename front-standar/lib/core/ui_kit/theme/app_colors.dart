import 'package:flutter/material.dart';

/// Palette de couleurs de l'application Velvet Pulse
abstract class AppColors {
  static const Color primary = Color(0xFF4F46E5);
   static const Color primaryDark = Color(0xFF150DB1);
  static const Color primaryLight = Color(0xFF655EF0);
  static const Color primaryLight2 = Color(0xFF9F9BEF);
  static const Color primaryLight3 = Color(0xFFE2DFFF);

  static const Color background = Color(0xFDFFFFFF);

  static const Color surface = Color(0xFFFFFFFF);

  static const Color inputFill = Color(0x0A9F9BEF);

  static const Color inputBorder = Color(0xFFB8A6AB);

  static const Color inputBorderFocused = Color(0xFF080452);

  static const Color textPrimary = Color(0xFF1A1A2E);

  static const Color textSecondary = Color(0xFF423036);

  static const Color textHint = Color(0xFF9C868A);

  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  static const Color erro = Color(0xFFFF3737);

  static const Color textDisabled = Color(0xFFA08090);
  static const Color textPlaceholder = Color(0xFF6B4F5C);
  static const Color textDescription = Color(0xFF6B4F5C);
  static const Color gray = Color(0xFF6B4F5C);
  static const Color red = Color(0xFFFF3737);
  static const Color green = Color(0xFF04E100);


  static const Color secondary = Color(0xFF6366F1);
  static const Color secondarLight = Color.fromARGB(255, 146, 147, 249);
  static const Color secondaryDark = Color.fromARGB(255, 29, 32, 160);
  static const Color backgroundGrey = Color(0xFFF8F0F4);
  static const Color buttonBackground = Color(0xFFFDE8EE);

  // ===== GRADIENTS =====
  /// Gradient principal pour boutons et accents
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Gradient pour la barre d'app
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [white, primary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Gradient pour le fond de l'écran d'auth (partie haute)
  static const LinearGradient authBackgroundGradient = LinearGradient(
    colors: [Color(0xFFFDE8EE), Color(0xFFF8F0F4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient profileCardGradient = LinearGradient(
    colors: [Color(0xFF8B1A35), Color(0xFFD0184A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color orange = Color(0xFFF7A800);
}
