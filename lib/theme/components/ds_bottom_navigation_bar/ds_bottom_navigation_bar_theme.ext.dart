part of '../../ds_theme.dart';

enum DSBottomNavigationBarVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO: Define variants for DSBottomNavigationBar component
}

class DSBottomNavigationBarThemeExtension
    extends ThemeExtension<DSBottomNavigationBarThemeExtension> {
  final DSBottomNavigationBarTheme dSBottomNavigationBarTheme =
      DSBottomNavigationBarTheme();

  @override
  ThemeExtension<DSBottomNavigationBarThemeExtension> copyWith() {
    return DSBottomNavigationBarThemeExtension();
  }

  @override
  ThemeExtension<DSBottomNavigationBarThemeExtension> lerp(
    covariant ThemeExtension<DSBottomNavigationBarThemeExtension>? other,
    double t,
  ) {
    return DSBottomNavigationBarThemeExtension();
  }
}
