import 'package:flutter/material.dart';
import 'typography.dart';

class DarkThemeColors {
  DarkThemeColors._();

  static const Color background = Color(0xFF0D0E1C);
  static const Color surface = Color(0xFF151729);
  static const Color surfaceVariant = Color(0xFF1E2038);
  static const Color card = Color(0xFF1A1C32);
  static const Color cardVariant = Color(0xFF22243E);

  static const Color primary = Color(0xFF7C6FF7);
  static const Color primaryLight = Color(0xFFA29BFE);
  static const Color primaryDark = Color(0xFF5A4DD0);
  static const Color primaryContainer = Color(0xFF2A2555);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF00D2D3);
  static const Color secondaryLight = Color(0xFF55EFC4);
  static const Color secondaryContainer = Color(0xFF003B3B);

  static const Color accent = Color(0xFFFD79A8);
  static const Color accentContainer = Color(0xFF4A1535);

  static const Color warning = Color(0xFFFDCB6E);
  static const Color error = Color(0xFFE17055);
  static const Color success = Color(0xFF00B894);
  static const Color info = Color(0xFF74B9FF);

  static const Color textPrimary = Color(0xFFECEEF5);
  static const Color textSecondary = Color(0xFF9EA0B5);
  static const Color textTertiary = Color(0xFF6B6E85);
  static const Color textDisabled = Color(0xFF3D4059);
  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFF2A2C44);
  static const Color border = Color(0xFF2E304A);
  static const Color shadow = Color(0x4D000000);

  static const Color shiftMorning = Color(0xFF7C6FF7);
  static const Color shiftEvening = Color(0xFFFD79A8);
  static const Color shiftNight = Color(0xFF636E72);
  static const Color shiftCustom = Color(0xFF00D2D3);
  static const Color offDay = Color(0xFF3D4059);

  static const Color shimmerBase = Color(0xFF1E2038);
  static const Color shimmerHighlight = Color(0xFF2A2C44);

  static const Color glassBg = Color(0x99FFFFFF);
  static const Color glassBorder = Color(0x4DFFFFFF);
  static const Color glassShadow = Color(0x0A000000);
}

ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkThemeColors.background,

    colorScheme: const ColorScheme.dark(
      primary: DarkThemeColors.primary,
      onPrimary: DarkThemeColors.onPrimary,
      primaryContainer: DarkThemeColors.primaryContainer,
      secondary: DarkThemeColors.secondary,
      secondaryContainer: DarkThemeColors.secondaryContainer,
      tertiary: DarkThemeColors.accent,
      tertiaryContainer: DarkThemeColors.accentContainer,
      surface: DarkThemeColors.surface,
      surfaceContainerHighest: DarkThemeColors.surfaceVariant,
      error: DarkThemeColors.error,
      onError: DarkThemeColors.onPrimary,
      onSurface: DarkThemeColors.textPrimary,
      onSurfaceVariant: DarkThemeColors.textSecondary,
      outline: DarkThemeColors.border,
      brightness: Brightness.dark,
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

    cardTheme: CardThemeData(
      color: DarkThemeColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: DarkThemeColors.border, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0.5,
      titleTextStyle: AppTypography.headlineSmall.copyWith(
        color: DarkThemeColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: DarkThemeColors.surface,
      elevation: 0,
      height: 72,
      indicatorColor: DarkThemeColors.primaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelSmall.copyWith(
            color: DarkThemeColors.primary,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.labelSmall.copyWith(color: DarkThemeColors.textTertiary);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: DarkThemeColors.primary, size: 24);
        }
        return const IconThemeData(color: DarkThemeColors.textTertiary, size: 24);
      }),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: DarkThemeColors.surfaceVariant,
      labelStyle: const TextStyle(color: DarkThemeColors.textSecondary, fontSize: 13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    ),

    dividerTheme: const DividerThemeData(
      color: DarkThemeColors.divider,
      thickness: 1,
      space: 1,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkThemeColors.surfaceVariant,
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
        borderSide: const BorderSide(color: DarkThemeColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: DarkThemeColors.error, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: DarkThemeColors.textTertiary, fontSize: 14),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkThemeColors.primary,
        foregroundColor: DarkThemeColors.onPrimary,
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
        backgroundColor: DarkThemeColors.primary,
        foregroundColor: DarkThemeColors.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DarkThemeColors.primary,
        textStyle: AppTypography.button,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: DarkThemeColors.primary,
        side: const BorderSide(color: DarkThemeColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTypography.button,
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: DarkThemeColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: DarkThemeColors.textPrimary,
      contentTextStyle: const TextStyle(color: DarkThemeColors.background, fontSize: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      behavior: SnackBarBehavior.floating,
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: DarkThemeColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
  );
}
