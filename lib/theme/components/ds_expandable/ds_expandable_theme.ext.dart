part of '../../ds_theme.dart';

class DSExpandableThemeExtension
    extends ThemeExtension<DSExpandableThemeExtension> {
  final DSExpandableTheme theme;

  DSExpandableThemeExtension({required this.theme});

  DSExpandableTheme getDSExpandableTheme() {
    return theme;
  }

  @override
  ThemeExtension<DSExpandableThemeExtension> copyWith({
    DSExpandableTheme? theme,
  }) {
    return DSExpandableThemeExtension(theme: theme ?? this.theme);
  }

  @override
  ThemeExtension<DSExpandableThemeExtension> lerp(
    covariant ThemeExtension<DSExpandableThemeExtension>? other,
    double t,
  ) {
    if (other is! DSExpandableThemeExtension) {
      return this;
    }
    return DSExpandableThemeExtension(theme: theme);
  }
}

extension DSExpandableThemeExtensionGetter on ThemeData {
  DSExpandableThemeExtension get dsExpandableTheme =>
      extension<DSExpandableThemeExtension>()!;
}
