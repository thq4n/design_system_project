// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../design_system_core/typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // primaryColor: DesignColors.primaryColor,
      textTheme: TypographyStyles.lightTextTheme,
    );
  }
}
