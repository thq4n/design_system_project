// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Sets the navigation bar color with optional animation
///
/// [color] - The color to set for the navigation bar
/// [animate] - Whether to animate the color change (default: true)
/// [systemNavigationBarColor] - The system navigation bar color (Android)
/// [systemNavigationBarDividerColor] - The navigation bar divider color (Android)
/// [systemNavigationBarIconBrightness] - The brightness of navigation bar icons (Android)
void setNavigationBarColor(
  Color color, {
  bool animate = true,
  Color? systemNavigationBarColor,
  Color? systemNavigationBarDividerColor,
  Brightness? systemNavigationBarIconBrightness,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: systemNavigationBarColor ?? color,
      systemNavigationBarDividerColor: systemNavigationBarDividerColor,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
    ),
  );
}

/// Sets the navigation bar to light theme (dark icons)
void setLightNavigationBar() {
  setNavigationBarColor(
    Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

/// Sets the navigation bar to dark theme (light icons)
void setDarkNavigationBar() {
  setNavigationBarColor(
    Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}

/// Sets the navigation bar to transparent
void setTransparentNavigationBar() {
  setNavigationBarColor(
    Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

/// Sets both status bar and navigation bar to light theme
void setLightSystemBars() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

/// Sets both status bar and navigation bar to dark theme
void setDarkSystemBars() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
