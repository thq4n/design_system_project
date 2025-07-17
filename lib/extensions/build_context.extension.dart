part of 'extensions.dart';

extension DSBuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  DSTextTheme get textTheme =>
      Theme.of(this).extension<DSTextThemeExtension>()!.textTheme;
  DSColors get colors =>
      Theme.of(this).extension<DsColorThemeExtension>()!.colors;
  DSColorUsages get colorUsages =>
      DSColorUsages();
}
