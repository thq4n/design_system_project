part of '../../ds_theme.dart';

class DSBasicBrandScreenFormThemeExtension
    extends ThemeExtension<DSBasicBrandScreenFormThemeExtension> {
  final DSTextTheme textTheme;
  DSBasicBrandScreenFormTheme get dSBasicBrandScreenFormTheme =>
      DSBasicBrandScreenFormTheme(
        titleMaxLines: 1,
        titleStyle:
            textTheme.lg?.semibold.copyWithColor(DSColorUsages.text.white),
        desStyle:
            textTheme.base?.medium.copyWithColor(DSColorUsages.text.white),
        appbarColor: DSColorUsages.background.brandPrimary,
        appbarForegroundColor: DSColorUsages.text.white,
        backgroundColor: DSColorUsages.background.secondary,
      );

  DSBasicBrandScreenFormThemeExtension(this.textTheme);

  @override
  ThemeExtension<DSBasicBrandScreenFormThemeExtension> copyWith() {
    return DSBasicBrandScreenFormThemeExtension(textTheme);
  }

  @override
  ThemeExtension<DSBasicBrandScreenFormThemeExtension> lerp(
    covariant ThemeExtension<DSBasicBrandScreenFormThemeExtension>? other,
    double t,
  ) {
    return DSBasicBrandScreenFormThemeExtension(textTheme);
  }
}
