part of '../../ds_theme.dart';

enum DSCalendarVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO: Define variants for DSCalendar component
}

class DSCalendarThemeExtension
    extends ThemeExtension<DSCalendarThemeExtension> {
  final DSCalendarTheme dSCalendarTheme = DSCalendarTheme();

  @override
  ThemeExtension<DSCalendarThemeExtension> copyWith() {
    return DSCalendarThemeExtension();
  }

  @override
  ThemeExtension<DSCalendarThemeExtension> lerp(
    covariant ThemeExtension<DSCalendarThemeExtension>? other,
    double t,
  ) {
    return DSCalendarThemeExtension();
  }
}
