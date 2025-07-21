part of '../../ds_theme.dart';

enum DSRadioVariants {
  primary,
  secondary,
  outline,
  ghost,
}

class DSRadioThemeExtension extends ThemeExtension<DSRadioThemeExtension> {
  final DSRadioTheme dSRadioTheme = DSRadioTheme();

  @override
  ThemeExtension<DSRadioThemeExtension> copyWith() {
    return DSRadioThemeExtension();
  }

  @override
  ThemeExtension<DSRadioThemeExtension> lerp(
    covariant ThemeExtension<DSRadioThemeExtension>? other,
    double t,
  ) {
    return DSRadioThemeExtension();
  }
}
