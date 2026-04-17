part of '../../ds_theme.dart';

class DSTimeOptionSelectorThemeExtension
    extends ThemeExtension<DSTimeOptionSelectorThemeExtension> {
  const DSTimeOptionSelectorThemeExtension({this.theme});

  final DSTimeOptionSelectorTheme? theme;

  DSTimeOptionSelectorTheme getDSTimeOptionSelectorTheme(BuildContext context) {
    return theme ?? DSTimeOptionSelectorTheme.fromContext(context);
  }

  @override
  ThemeExtension<DSTimeOptionSelectorThemeExtension> copyWith({
    DSTimeOptionSelectorTheme? theme,
  }) {
    return DSTimeOptionSelectorThemeExtension(theme: theme ?? this.theme);
  }

  @override
  ThemeExtension<DSTimeOptionSelectorThemeExtension> lerp(
    covariant ThemeExtension<DSTimeOptionSelectorThemeExtension>? other,
    double t,
  ) {
    return DSTimeOptionSelectorThemeExtension(theme: theme);
  }
}
