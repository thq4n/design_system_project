part of '../../ds_theme.dart';

class DSBasicScreenFormThemeExtension
    extends ThemeExtension<DSBasicScreenFormThemeExtension> {
  final DSTextTheme textTheme;
  DSBasicScreenFormTheme get dSBasicScreenFormTheme => DSBasicScreenFormTheme(
        titleMaxLines: 1,
        titleStyle: textTheme.lg?.semibold,
        appbarColor: DSColorUsages.background.primary,
        appbarForegroundColor: DSColorUsages.text.primary,
        backgroundColor: DSColorUsages.background.scaffoldBackground,
        enableBlur: true,
        maxBlurOpacity: 0.7,
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
