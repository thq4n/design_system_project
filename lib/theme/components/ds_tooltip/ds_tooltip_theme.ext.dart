part of '../../ds_theme.dart';

class DSTooltipThemeExtension extends ThemeExtension<DSTooltipThemeExtension> {
  final DSTextTheme textTheme;

  DSTooltipThemeExtension({required this.textTheme});

  DSTooltipTheme get tooltipTheme => DSTooltipTheme(
        borderRadius: DSRadiuses.radiusSm,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: textTheme.sm?.medium
            .copyWithColor(DSColorUsages.text.primary.white),
        boxDecoration: BoxDecoration(
          color: DSColorUsages.background.primary.black,
          borderRadius: DSRadiuses.radiusSm.borderRadiusGeometry,
        ),
        showDuration: const Duration(seconds: 3),
        waitDuration: const Duration(milliseconds: 400),
        verticalOffset: 0,
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
