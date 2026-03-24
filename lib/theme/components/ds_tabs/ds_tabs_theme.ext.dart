part of '../../ds_theme.dart';

enum DSTabsVariants {
  primary,
  secondary,
  outline,
  ghost,
}

class DSTabsThemeExtension extends ThemeExtension<DSTabsThemeExtension> {
  DSTabsThemeExtension({this.theme});

  final DSTabsTheme? theme;

  DSTabsTheme getDSTabsTheme(BuildContext context) {
    return theme ?? DSTabsTheme.fromContext(context);
  }

  @override
  ThemeExtension<DSTabsThemeExtension> copyWith({DSTabsTheme? theme}) {
    return DSTabsThemeExtension(theme: theme ?? this.theme);
  }

  @override
  ThemeExtension<DSTabsThemeExtension> lerp(
    covariant ThemeExtension<DSTabsThemeExtension>? other,
    double t,
  ) {
    return DSTabsThemeExtension(theme: theme);
  }
}
