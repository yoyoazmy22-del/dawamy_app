import 'package:flutter/material.dart';
import 'typography.dart';

class LightThemeColors {
  LightThemeColors._();

  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFEEF0F6);
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

  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF00B894);
  static const Color info = Color(0xFF3498DB);

  static const Color textPrimary = Color(0xFF1A1D2E);
  static const Color textSecondary = Color(0xFF6C7280);
  static const Color textTertiary = Color(0xFFA0A5B5);
  static const Color textDisabled = Color(0xFFC5C9D6);
  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFE8EAF0);
  static const Color border = Color(0xFFE2E5ED);
  static const Color shadow = Color(0x1A000000);

  static const Color shiftMorning = Color(0xFF6C5CE7);
  static const Color shiftEvening = Color(0xFFFF6B81);
  static const Color shiftNight = Color(0xFF2D3436);
  static const Color shiftCustom = Color(0xFF00CEC9);
  static const Color offDay = Color(0xFFB2BEC3);

  static const Color shimmerBase = Color(0xFFE8EAF0);
  static const Color shimmerHighlight = Color(0xFFF1F3F8);

  static const Color glassBg = Color(0xF2FFFFFF);
  static const Color glassBorder = Color(0x4DFFFFFF);
  static const Color glassShadow = Color(0x0A000000);
}

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightThemeColors.background,

    colorScheme: const ColorScheme.light(
      primary: LightThemeColors.primary,
      onPrimary: LightThemeColors.onPrimary,
      primaryContainer: LightThemeColors.primaryContainer,
      secondary: LightThemeColors.secondary,
      secondaryContainer: LightThemeColors.secondaryContainer,
      tertiary: LightThemeColors.accent,
      tertiaryContainer: LightThemeColors.accentContainer,
      surface: LightThemeColors.surface,
      surfaceContainerHighest: LightThemeColors.surfaceVariant,
      error: LightThemeColors.error,
      onError: LightThemeColors.onPrimary,
      onSurface: LightThemeColors.textPrimary,
      onSurfaceVariant: LightThemeColors.textSecondary,
      outline: LightThemeColors.border,
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
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: LightThemeColors.border, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0.5,
      titleTextStyle: AppTypography.headlineSmall.copyWith(
        color: LightThemeColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: LightThemeColors.surface,
      elevation: 0,
      height: 72,
      indicatorColor: LightThemeColors.primaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelSmall.copyWith(
            color: LightThemeColors.primary,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.labelSmall.copyWith(color: LightThemeColors.textTertiary);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: LightThemeColors.primary, size: 24);
        }
        return const IconThemeData(color: LightThemeColors.textTertiary, size: 24);
      }),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: LightThemeColors.surfaceVariant,
      labelStyle: const TextStyle(color: LightThemeColors.textSecondary, fontSize: 13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LightThemeColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LightThemeColors.error, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: LightThemeColors.textTertiary, fontSize: 14),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LightThemeColors.primary,
        foregroundColor: LightThemeColors.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTypography.button,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: LightThemeColors.primary,
        foregroundColor: LightThemeColors.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
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
        side: const BorderSide(color: LightThemeColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTypography.button,
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: LightThemeColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: LightThemeColors.textPrimary,
      contentTextStyle: const TextStyle(color: LightThemeColors.textOnDark, fontSize: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      behavior: SnackBarBehavior.floating,
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: LightThemeColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
  );
}
