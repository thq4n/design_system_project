part of '../../ds_theme.dart';

enum DSCheckboxVariants {
  primary,
  secondary,
  outline,
  ghost,
}

class DSCheckboxThemeExtension
    extends ThemeExtension<DSCheckboxThemeExtension> {
  final DSCheckboxTheme dSCheckboxTheme = DSCheckboxTheme(
    activeBorderColor: const DSColors().brand.primary,
    inactiveBorderColor: const DSColors().gray.shade200,
    activeColor: const DSColors().brand.primary,
    inactiveColor: const DSColors().gray.white,
    checkColor: const DSColors().gray.white,
    borderRadius: 4,
    borderWidth: 1,
    size: 20,
    iconSize: 16,
    labelSpacing: 12,
  );

  @override
  ThemeExtension<DSCheckboxThemeExtension> copyWith() {
    return DSCheckboxThemeExtension();
  }

  @override
  ThemeExtension<DSCheckboxThemeExtension> lerp(
    covariant ThemeExtension<DSCheckboxThemeExtension>? other,
    double t,
  ) {
    return DSCheckboxThemeExtension();
  }
}
