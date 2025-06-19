part of '../../ds_theme.dart';

class DSAppTheme {
  final String name;
  final ThemeData themeData;

  DSAppTheme({
    required this.name,
    required this.themeData,
  });

  static final DSTextTheme _textTheme = DSTextTheme._create();

  static final ThemeData _baseTheme = ThemeData(
    fontFamily: Fonts.sFProDisplay,
    textTheme: _textTheme,
    extensions: [
      DSTextThemeExtension(textTheme: _textTheme),
      DsColorThemeExtension(),
    ],
  );

  static ThemeData get lightTheme {
    return _baseTheme.copyWith(
      colorScheme: DSColorScheme.lightScheme,
    );
  }

  static ThemeData get darkTheme {
    return _baseTheme.copyWith(
      colorScheme: DSColorScheme.darkScheme,
    );
  }

  factory DSAppTheme.factory({
    required Brightness brightness,
    required ThemeData themeData,
  }) {
    return DSAppTheme(
      name: brightness.name,
      themeData: themeData,
    );
  }

  factory DSAppTheme.light() {
    return DSAppTheme.factory(
      brightness: Brightness.light,
      themeData: lightTheme,
    );
  }

  factory DSAppTheme.dark() {
    return DSAppTheme.factory(
      brightness: Brightness.dark,
      themeData: darkTheme,
    );
  }
}
