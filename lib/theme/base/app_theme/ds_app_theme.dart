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
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DSColorUsages.background.primary,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: DSColorUsages.border.primary,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: DSColorUsages.border.primary,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: DSColorUsages.border.brand.shape200,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: DSColorUsages.border.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: DSColorUsages.border.error,
          width: 1,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: DSColorUsages.border.primary,
          width: 1,
        ),
      ),
      labelStyle:
          _textTheme.base?.medium.copyWithColor(DSColorUsages.text.tertiary),
      floatingLabelStyle:
          _textTheme.xs?.medium.copyWithColor(DSColorUsages.text.tertiary),
      hintStyle:
          _textTheme.base?.medium.copyWithColor(DSColorUsages.text.tertiary),
      errorStyle: _textTheme.xs?.medium.copyWithColor(DSColorUsages.text.error),
      suffixIconColor: DSColorUsages.icon.secondary,
      prefixIconColor: DSColorUsages.icon.secondary,
    ),
    extensions: [
      DSTextThemeExtension(textTheme: _textTheme),
      DsColorThemeExtension(),
      DSButtonThemeExtension(textTheme: _textTheme),
      DSIconButtonThemeExtension(),
      DSInputThemeExtension(),
      DSBasicBrandScreenFormThemeExtension(_textTheme),
      DSBasicScreenFormThemeExtension(_textTheme),
      DSRadioThemeExtension(),
      DSBottomNavigationBarThemeExtension(),
      DSMediaPickerThemeExtension(textTheme: _textTheme),
      DSBadgeNotificationThemeExtension(textTheme: _textTheme),
      DSChipThemeExtension(textTheme: _textTheme),
      DSCalendarThemeExtension(textTheme: _textTheme),
      DSAvatarThemeExtension(textTheme: _textTheme),
      DSTagThemeExtension(textTheme: _textTheme),
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
