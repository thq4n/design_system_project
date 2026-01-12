part of '../../ds_theme.dart';

class DSTimelineThemeExtension
    extends ThemeExtension<DSTimelineThemeExtension> {
  final DSTextTheme textTheme;
  final dsColors = const DSColors();

  DSTimelineThemeExtension({required this.textTheme});

  DSTimelineTheme getDSTimelineTheme() {
    return DSTimelineTheme(
      dotColor: dsColors.gray.white,
      dotBorderColor: dsColors.blue.shape500,
      dotSize: 16,
      dotBorderThickness: 4,
      connectorColor: dsColors.blue.shape500,
      connectorThickness: 2.0,
      itemSpacing: 16.0,
      animationDuration: const Duration(milliseconds: 600),
      animationDelay: const Duration(milliseconds: 150),
      padding: EdgeInsets.zero,
      horizontalSpacing: 12,
      separatorLineColor: DSColorUsages.border.tertiary,
      separatorLineThickness: 1.0,
      separatorPadding: const EdgeInsets.symmetric(vertical: 8),
      separatorTextStyle:
          textTheme.sm?.regular.copyWithColor(DSColorUsages.text.tertiary),
    );
  }

  @override
  ThemeExtension<DSTimelineThemeExtension> copyWith() {
    return DSTimelineThemeExtension(textTheme: textTheme);
  }

  @override
  ThemeExtension<DSTimelineThemeExtension> lerp(
    covariant ThemeExtension<DSTimelineThemeExtension>? other,
    double t,
  ) {
    return DSTimelineThemeExtension(textTheme: textTheme.lerp(textTheme, t));
  }
}
