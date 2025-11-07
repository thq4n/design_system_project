part of '../../ds_theme.dart';

class DSTooltipThemeExtension extends ThemeExtension<DSTooltipThemeExtension> {
  final DSTextTheme textTheme;

  DSTooltipThemeExtension({required this.textTheme});

  DSTooltipTheme tooltipTheme = DSTooltipTheme(
    borderRadius: DSRadiuses.radiusSm,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );

  @override
  ThemeExtension<DSTooltipThemeExtension> copyWith({DSTextTheme? textTheme}) {
    return DSTooltipThemeExtension(textTheme: textTheme ?? this.textTheme);
  }

  @override
  ThemeExtension<DSTooltipThemeExtension> lerp(
    covariant ThemeExtension<DSTooltipThemeExtension>? other,
    double t,
  ) {
    return DSTooltipThemeExtension(
      textTheme: textTheme,
    );
  }
}
