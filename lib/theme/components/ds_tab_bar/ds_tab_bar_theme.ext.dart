part of '../../ds_theme.dart';

/// Theme extension for DSTabBar component.
///
/// Provides theme configuration methods for DSTabBar styling.
class DSTabBarThemeExtension extends ThemeExtension<DSTabBarThemeExtension> {
  final DSTextTheme textTheme;
  final dsColors = const DSColors();

  DSTabBarThemeExtension({required this.textTheme});

  /// Gets the DSTabBar theme configuration.
  DSTabBarTheme getDSTabBarTheme() {
    return DSTabBarTheme(
      backgroundColor: DSColorUsages.background.primary,
      labelStyle:
          textTheme.base?.semibold.copyWithColor(DSColorUsages.text.linkRed),
      unselectedLabelStyle:
          textTheme.base?.regular.copyWithColor(DSColorUsages.text.tertiary),
      indicatorGradientColors: [
        dsColors.brand
            .custom(0xFFFF3F3F)
            .withOpacity(0.3), // #FEE4E2 equivalent
        dsColors.brand.white.withOpacity(0), // #FFFFFF
      ],
      indicatorGradientStops: const [0.1869, 0.8836], // 18.69% and 88.36%
      indicatorGradientBegin: Alignment.bottomCenter,
      indicatorGradientEnd: Alignment.topCenter,
      indicatorBorderColor: dsColors.brand.shade600,
      indicatorBorderWidth: 2,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  @override
  ThemeExtension<DSTabBarThemeExtension> copyWith() {
    return DSTabBarThemeExtension(textTheme: textTheme);
  }

  @override
  ThemeExtension<DSTabBarThemeExtension> lerp(
    covariant ThemeExtension<DSTabBarThemeExtension>? other,
    double t,
  ) {
    return DSTabBarThemeExtension(
      textTheme: textTheme.lerp(textTheme, t),
    );
  }
}
