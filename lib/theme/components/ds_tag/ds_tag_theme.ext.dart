part of '../../ds_theme.dart';

class DSTagThemeExtension extends ThemeExtension<DSTagThemeExtension> {
  final DSTextTheme textTheme;
  final dsColors = const DSColors();

  DSTagThemeExtension({required this.textTheme});

  DSTagTheme _dSCustomTagTheme(DSTagSizes size) {
    return DSTagTheme(
      borderRadius: _getBorderRadiusBySize(size),
      padding: _getPaddingBySize(size),
      textStyle: _getTextStyleBySize(size),
      iconSize: DSIconSizes.size16,
      elementSpacing: 4,
    );
  }

  DSTagTheme _dSErrorTagTheme(DSTagSizes size) {
    return DSTagTheme(
      mainColor: dsColors.orange,
      borderRadius: _getBorderRadiusBySize(size),
      padding: _getPaddingBySize(size),
      textStyle: _getTextStyleBySize(size),
      iconSize: DSIconSizes.size16,
      elementSpacing: 4,
    );
  }

  DSTagTheme _dSInfoTagTheme(DSTagSizes size) {
    return DSTagTheme(
      mainColor: dsColors.blue,
      borderRadius: _getBorderRadiusBySize(size),
      padding: _getPaddingBySize(size),
      textStyle: _getTextStyleBySize(size),
      iconSize: DSIconSizes.size16,
      elementSpacing: 4,
    );
  }

  DSTagTheme _dSSuccessTagTheme(DSTagSizes size) {
    return DSTagTheme(
      mainColor: dsColors.green,
      borderRadius: _getBorderRadiusBySize(size),
      padding: _getPaddingBySize(size),
      textStyle: _getTextStyleBySize(size),
      iconSize: DSIconSizes.size16,
      elementSpacing: 4,
    );
  }

  DSTagTheme _dSDefaultTagTheme(DSTagSizes size) {
    return DSTagTheme(
      mainColor: DSColorUsages.text.primary,
      borderRadius: _getBorderRadiusBySize(size),
      padding: _getPaddingBySize(size),
      textStyle: _getTextStyleBySize(size),
      iconSize: DSIconSizes.size16,
      elementSpacing: 4,
    );
  }

  DSTagTheme _dSBrandTagTheme(DSTagSizes size) {
    return DSTagTheme(
      mainColor: dsColors.brand,
      borderRadius: _getBorderRadiusBySize(size),
      padding: _getPaddingBySize(size),
      textStyle: _getTextStyleBySize(size),
      iconSize: DSIconSizes.size16,
      elementSpacing: 4,
    );
  }

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

  DSTextStyle? _getTextStyleBySize(DSTagSizes size) {
    switch (size) {
      case DSTagSizes.sm:
        return textTheme.base?.medium;
      case DSTagSizes.md:
        return textTheme.sm?.medium;
    }
  }

  DSTagTheme getDStagThem(DSTagStyles style, DSTagSizes size) {
    return switch (style) {
      DSTagStyles.custom => _dSCustomTagTheme(size),
      DSTagStyles.error => _dSErrorTagTheme(size),
      DSTagStyles.success => _dSSuccessTagTheme(size),
      DSTagStyles.default_ => _dSDefaultTagTheme(size),
      DSTagStyles.brand => _dSBrandTagTheme(size),
      DSTagStyles.info => _dSInfoTagTheme(size),
    };
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
