part of '../../ds_theme.dart';

class DSBasicScreenFormThemeExtension
    extends ThemeExtension<DSBasicScreenFormThemeExtension> {
  final DSTextTheme textTheme;
  DSBasicScreenFormTheme get dSBasicScreenFormTheme => DSBasicScreenFormTheme(
        titleMaxLines: 1,
        titleStyle:
            textTheme.lg?.semibold.copyWithColor(DSColorUsages.text.white),
        desStyle:
            textTheme.base?.medium.copyWithColor(DSColorUsages.text.white),
        appbarColor: DSColorUsages.background.brandPrimary,
        appbarForegroundColor: DSColorUsages.text.white,
        backgroundColor: DSColorUsages.background.secondary,
      );

  DSBasicScreenFormThemeExtension(this.textTheme);

  @override
  ThemeExtension<DSBasicScreenFormThemeExtension> copyWith() {
    return DSBasicScreenFormThemeExtension(textTheme);
  }

  @override
  ThemeExtension<DSBasicScreenFormThemeExtension> lerp(
    covariant ThemeExtension<DSBasicScreenFormThemeExtension>? other,
    double t,
  ) {
    return DSBasicScreenFormThemeExtension(textTheme);
  }
}
