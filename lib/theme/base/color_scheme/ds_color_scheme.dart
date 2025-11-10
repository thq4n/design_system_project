part of '../../ds_theme.dart';

class DSColorScheme {
  // static ColorScheme light = ColorScheme(
  //   brightness: Brightness.light,
  //   primary: DSColors.brand.primary,
  //   onPrimary: DSColors.white.primary,
  //   primaryContainer: DSColors.brand.shape100,
  //   onPrimaryContainer: DSColors.brand.shade900,
  //   secondary: DSColors.blue.primary,
  //   onSecondary: DSColors.white.primary,
  //   secondaryContainer: DSColors.blue.shape100,
  //   onSecondaryContainer: DSColors.blue.shade900,
  //   tertiary: DSColors.purple.primary,
  //   onTertiary: DSColors.white.primary,
  //   tertiaryContainer: DSColors.purple.shape100,
  //   onTertiaryContainer: DSColors.purple.shade900,
  //   error: DSColors.orange.primary,
  //   onError: DSColors.white.primary,
  //   errorContainer: DSColors.orange.shape100,
  //   onErrorContainer: DSColors.orange.shade900,
  //   background: DSColors.white.shape50,
  //   onBackground: DSColors.black.primary,
  //   surface: DSColors.white.primary,
  //   onSurface: DSColors.black.primary,
  //   surfaceVariant: DSColors.gray.shape100,
  //   onSurfaceVariant: DSColors.gray.shade600,
  //   outline: DSColors.gray.shape300,
  //   shadow: DSColors.black.shape50,
  //   inverseSurface: DSColors.gray.shade900,
  //   onInverseSurface: DSColors.white.primary,
  //   inversePrimary: DSColors.brand.shape300,
  //   surfaceTint: DSColors.brand.primary,
  // );

  static const DSColors _colors = DSColors();

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: _colors.brand.primary, // Màu chủ đạo
    brightness: Brightness.light,
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: _colors.brand.primary, // Cùng màu seed
    brightness: Brightness.dark,
  );
}
