part of '../../ds_theme.dart';

class DSTextThemeExtension extends ThemeExtension<DSTextThemeExtension> {
  final DSTextTheme textTheme;

  DSTextThemeExtension({
    required this.textTheme,
  });

  @override
  DSTextThemeExtension copyWith({DSTextTheme? textTheme}) {
    return DSTextThemeExtension(textTheme: textTheme ?? this.textTheme);
  }

  @override
  DSTextThemeExtension lerp(
    covariant DSTextThemeExtension? other,
    double t,
  ) {
    return DSTextThemeExtension(
      textTheme: textTheme.lerp(other?.textTheme, t),
    );
  }
}
