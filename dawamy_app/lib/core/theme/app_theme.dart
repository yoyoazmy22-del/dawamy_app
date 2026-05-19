import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => lightTheme;
  static ThemeData get dark => darkTheme;

  static ThemeData get defaultTheme => light;

  static ThemeData fromMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
      default:
        return light;
    }
  }

  static ThemeMode themeModeFromString(String? mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static String stringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      default:
        return 'system';
    }
  }
}
