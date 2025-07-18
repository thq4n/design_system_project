part of '../../ds_theme.dart';

enum DSInputVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO: Define variants for DSInput component
}

class DSInputThemeExtension extends ThemeExtension<DSInputThemeExtension> {
  final DSInputTheme dSInputTheme = DSInputTheme();

  @override
  ThemeExtension<DSInputThemeExtension> copyWith() {
    return DSInputThemeExtension();
  }

  @override
  ThemeExtension<DSInputThemeExtension> lerp(
    covariant ThemeExtension<DSInputThemeExtension>? other,
    double t,
  ) {
    return DSInputThemeExtension();
  }
}
