import 'package:flutter/material.dart';
import 'typography.dart';

class LightThemeColors {
  LightThemeColors._();

  static const Color background = Color(0xFFF8F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F8);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardVariant = Color(0xFFF8F9FC);

  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFFA29BFE);
  static const Color primaryDark = Color(0xFF4A3DB8);
  static const Color primaryContainer = Color(0xFFF0EEFF);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF00CEC9);
  static const Color secondaryLight = Color(0xFF55EFC4);
  static const Color secondaryContainer = Color(0xFFE0FFF8);

  static const Color accent = Color(0xFFFD79A8);
  static const Color accentContainer = Color(0xFFFFF0F5);

  static const Color warning = Color(0xFFFDCB6E);
  static const Color error = Color(0xFFE17055);
  static const Color success = Color(0xFF00B894);
  static const Color info = Color(0xFF74B9FF);

  static const Color textPrimary = Color(0xFF1A1D2E);
  static const Color textSecondary = Color(0xFF6C7280);
  static const Color textTertiary = Color(0xFFA0A5B5);
  static const Color textDisabled = Color(0xFFC5C9D6);
  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFE8EAF0);
  static const Color border = Color(0xFFE2E5ED);
  static const Color shadow = Color(0x1A000000);

  static const Color shiftMorning = Color(0xFF6C5CE7);
  static const Color shiftEvening = Color(0xFFFD79A8);
  static const Color shiftNight = Color(0xFF2D3436);
  static const Color shiftCustom = Color(0xFF00CEC9);
  static const Color offDay = Color(0xFFB2BEC3);

  static const Color shimmerBase = Color(0xFFE8EAF0);
  static const Color shimmerHighlight = Color(0xFFF1F3F8);

  static const Color glassBg = Color(0x99FFFFFF);
  static const Color glassBorder = Color(0x4DFFFFFF);
  static const Color glassShadow = Color(0x0A000000);
}

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: LightThemeColors.primary,
    scaffoldBackgroundColor: LightThemeColors.background,
    colorScheme: const ColorScheme.light(
      primary: LightThemeColors.primary,
      secondary: LightThemeColors.secondary,
      surface: LightThemeColors.surface,
      error: LightThemeColors.error,
      onPrimary: LightThemeColors.onPrimary,
      onSecondary: LightThemeColors.textPrimary,
      onSurface: LightThemeColors.textPrimary,
      onError: LightThemeColors.onPrimary,
      brightness: Brightness.light,
    ),

    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      titleLarge: AppTypography.titleLarge,
      titleMedium: AppTypography.titleMedium,
      titleSmall: AppTypography.titleSmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    ),
    cardTheme: CardTheme(
      color: LightThemeColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: LightThemeColors.border, width: 0.5),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineSmall,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: LightThemeColors.surface,
      elevation: 0,
      selectedItemColor: LightThemeColors.primary,
      unselectedItemColor: LightThemeColors.textTertiary,
      type: BottomNavigationBarType.fixed,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: LightThemeColors.surfaceVariant,
      labelStyle: const TextStyle(color: LightThemeColors.textSecondary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: LightThemeColors.divider,
      thickness: 1,
      space: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LightThemeColors.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: LightThemeColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: LightThemeColors.error, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: LightThemeColors.textTertiary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LightThemeColors.primary,
        foregroundColor: LightThemeColors.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTypography.button,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LightThemeColors.primary,
        textStyle: AppTypography.button,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: LightThemeColors.primary,
        side: const BorderSide(color: LightThemeColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTypography.button,
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: LightThemeColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: LightThemeColors.textPrimary,
      contentTextStyle: const TextStyle(color: LightThemeColors.textOnDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
