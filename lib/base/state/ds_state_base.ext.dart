part of '../ds_base.dart';

extension DSStateBaseExt on DSStateBase {
  ThemeData get theme => Theme.of(context);

  DSColors get colorTheme => theme.extension<DsColorThemeExtension>()!.colors;

  void hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void triggerSelectionHaptic() {
    Gaimon.selection();
  }

  void showToast({
    required String message,
    String? icon,
    ToastType? toastType,
    double? top = 85,
    double? left,
    double? right,
    double? bottom,
  }) {
    DSToast.show(
      context,
      message: message,
      icon: icon,
      toastType: toastType ?? ToastType.success,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
    );
  }

  void showErrorToast({
    required String message,
    String? icon,
    double? top = 85,
    double? left,
    double? right,
    double? bottom,
  }) {
    DSToast.show(
      context,
      message: message,
      icon: icon,
      toastType: ToastType.error,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
    );
  }
}
