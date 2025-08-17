part of '../ds_base.dart';

extension DSStateBaseExt on DSStateBase {
  ThemeData get theme => Theme.of(context);

  DSTextTheme get textTheme =>
      theme.extension<DSTextThemeExtension>()!.textTheme;

  DSColors get colorTheme => theme.extension<DsColorThemeExtension>()!.colors;

  void hideKeyBoard() {
    return focusNode.requestFocus(FocusNode());
  }

  void triggerSelectionHaptic() {
    Gaimon.selection();
  }
}
