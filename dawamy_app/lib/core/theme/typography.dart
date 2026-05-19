import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get displayLarge => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.3,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.2,
      );

  static TextStyle get headlineLarge => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle get headlineMedium => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle get headlineSmall => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get titleLarge => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get labelLarge => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.3,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.4,
      );

  static TextStyle get caption => const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get button => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get buttonSmall => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get overline => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 1.0,
      );

  static TextStyle get largeNumber => const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -1,
      );

  static TextStyle get mediumNumber => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.5,
      );
}
