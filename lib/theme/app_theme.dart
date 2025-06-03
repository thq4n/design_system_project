// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../design_system_core/typography.dart';
import '../gen/fonts.gen.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // primaryColor: DesignColors.primaryColor,
      textTheme: TypographyStyles.lightTextTheme,
      fontFamily: Fonts.sFProDisplay,
    );
  }
}
