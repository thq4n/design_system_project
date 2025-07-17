part of '../../ds_theme.dart';

class DsColorThemeExtension extends ThemeExtension<DsColorThemeExtension> {
  final DSColors colors;

  DsColorThemeExtension({
    this.colors = const DSColors(),
  });

  @override
  ThemeExtension<DsColorThemeExtension> copyWith({DSColors? colors}) {
    return DsColorThemeExtension(colors: colors ?? this.colors);
  }

  @override
  ThemeExtension<DsColorThemeExtension> lerp(
    covariant ThemeExtension<DsColorThemeExtension>? other,
    double t,
  ) {
    if (other is! DsColorThemeExtension) {
      return this;
    }
    return DsColorThemeExtension(colors: colors.lerp(other.colors, t));
  }
}
