part of '../../ds_theme.dart';

class DSColorScheme {
  // static ColorScheme light = ColorScheme(
  //   brightness: Brightness.light,
  //   primary: DSColors.brand.primary,
  //   onPrimary: DSColors.white.primary,
  //   primaryContainer: DSColors.brand.tint100,
  //   onPrimaryContainer: DSColors.brand.shade900,
  //   secondary: DSColors.blue.primary,
  //   onSecondary: DSColors.white.primary,
  //   secondaryContainer: DSColors.blue.tint100,
  //   onSecondaryContainer: DSColors.blue.shade900,
  //   tertiary: DSColors.purple.primary,
  //   onTertiary: DSColors.white.primary,
  //   tertiaryContainer: DSColors.purple.tint100,
  //   onTertiaryContainer: DSColors.purple.shade900,
  //   error: DSColors.orange.primary,
  //   onError: DSColors.white.primary,
  //   errorContainer: DSColors.orange.tint100,
  //   onErrorContainer: DSColors.orange.shade900,
  //   background: DSColors.white.tint50,
  //   onBackground: DSColors.black.primary,
  //   surface: DSColors.white.primary,
  //   onSurface: DSColors.black.primary,
  //   surfaceVariant: DSColors.gray.tint100,
  //   onSurfaceVariant: DSColors.gray.shade600,
  //   outline: DSColors.gray.tint300,
  //   shadow: DSColors.black.tint50,
  //   inverseSurface: DSColors.gray.shade900,
  //   onInverseSurface: DSColors.white.primary,
  //   inversePrimary: DSColors.brand.tint300,
  //   surfaceTint: DSColors.brand.primary,
  // );

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: DSColors.brand.primary, // Màu chủ đạo
    brightness: Brightness.light,
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: DSColors.brand.primary, // Cùng màu seed
    brightness: Brightness.dark,
  );
}
