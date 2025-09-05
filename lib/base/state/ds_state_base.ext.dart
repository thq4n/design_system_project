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

  void showToast({
    required String message,
    String? icon,
    ToastType? toastType,
    double? top = 85,
    double? left,
    double? right,
    double? bottom,
  }) {
    fToast.removeQueuedCustomToasts();
    fToast.removeCustomToast();
    fToast.showToast(
      child: AppToastWidget(
        message: message,
        icon: icon,
        toastType: toastType ?? ToastType.error,
      ),
      toastDuration: const Duration(seconds: 3),
      positionedToastBuilder: (context, child, gravity) {
        return Positioned(
          top: top != null ? max(16, top) : null,
          left: left,
          right: right,
          bottom: bottom,
          child: child,
        );
      },
    );
  }
}
