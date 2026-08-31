part of '../../ds_theme.dart';

class DSTagThemeExtension extends ThemeExtension<DSTagThemeExtension> {
  final DSTextTheme textTheme;
  final dsColors = const DSColors();

  DSTagThemeExtension({required this.textTheme});

  DSRadius _getBorderRadiusBySize(DSTagSizes size) {
    switch (size) {
      case DSTagSizes.sm:
        return DSRadiuses.radiusMd;
      case DSTagSizes.md:
        return DSRadiuses.radiusLg;
    }
  }

  EdgeInsets _getPaddingBySize(DSTagSizes size) {
    switch (size) {
      case DSTagSizes.sm:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case DSTagSizes.md:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
    }
  }

  DSTextStyle? _getTextStyleBySize(
    DSTagSizes size,
    DSTagColorIntensity colorIntensity,
  ) {
    final textStyle = switch (size) {
      DSTagSizes.sm => textTheme.xxs?.medium,
      DSTagSizes.md => textTheme.sm?.medium,
    };

    return textStyle;
  }

  DSTagTheme getDStagThem(
    DSTagStyles style,
    DSTagSizes size,
    DSTagColorIntensity colorIntensity,
  ) {
    final mainColor = switch (style) {
      DSTagStyles.custom => null,
      DSTagStyles.error => dsColors.orange,
      DSTagStyles.success => dsColors.green,
      DSTagStyles.default_ => DSColorUsages.text.primary,
      DSTagStyles.brand => dsColors.brand,
      DSTagStyles.info => dsColors.blue,
      DSTagStyles.warning => dsColors.yellow,
    };

    final textColor = switch (colorIntensity) {
      DSTagColorIntensity.low => mainColor?.shade500,
      DSTagColorIntensity.medium => mainColor?.shade600,
      DSTagColorIntensity.high => mainColor?.shade700,
    };

    return DSTagTheme(
      mainColor: mainColor,
      borderRadius: _getBorderRadiusBySize(size),
      padding: _getPaddingBySize(size),
      textStyle:
          _getTextStyleBySize(size, colorIntensity)?.copyWithColor(textColor),
      iconSize: DSIconSizes.size16,
      elementSpacing: 4,
    );
  }

  @override
  ThemeExtension<DSTagThemeExtension> copyWith() {
    return DSTagThemeExtension(textTheme: textTheme);
  }

  @override
  ThemeExtension<DSTagThemeExtension> lerp(
    covariant ThemeExtension<DSTagThemeExtension>? other,
    double t,
  ) {
    return DSTagThemeExtension(textTheme: textTheme.lerp(textTheme, t));
  }
}
