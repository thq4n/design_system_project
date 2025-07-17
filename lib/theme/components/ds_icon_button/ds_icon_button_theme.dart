part of '../../ds_theme.dart';

class DSIconButtonTheme {
  final DSIconButtonStateTheme defaultState;
  final DSIconButtonStateTheme pressedState;
  final DSIconButtonStateTheme activeState;
  final DSIconButtonStateTheme disableState;

  DSIconButtonTheme({
    required this.defaultState,
    required this.pressedState,
    required this.activeState,
    required this.disableState,
  });
}

class DSIconButtonStateTheme {
  final DSColor backgroundColor;
  final DSColor iconColor;

  DSIconButtonStateTheme({
    required this.backgroundColor,
    required this.iconColor,
  });
}
