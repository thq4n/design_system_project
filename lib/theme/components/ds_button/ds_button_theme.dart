part of '../../ds_theme.dart';

class DSButtonTheme {
  final DSButtonStateTheme defaultState;
  final DSButtonStateTheme pressedState;
  final DSButtonStateTheme activeState;
  final DSButtonStateTheme disableState;

  DSButtonTheme({
    required this.defaultState,
    required this.pressedState,
    required this.activeState,
    required this.disableState,
  });
}

class DSButtonStateTheme {
  final DSTextStyle? textStyle;
  final DSColor backgroundColor;
  final DSColor prefixIconColor;
  final DSColor suffixIconColor;

  DSButtonStateTheme({
    required this.textStyle,
    required this.backgroundColor,
    required this.prefixIconColor,
    required this.suffixIconColor,
  });
}
