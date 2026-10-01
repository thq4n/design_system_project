import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/constants.dart';
import 'app_toast_widget.dart';

/// Shows the shared app toast from any [BuildContext].
class DSToast {
  const DSToast._();

  static void dismiss() {
    FToast()
      ..removeQueuedCustomToasts()
      ..removeCustomToast();
  }

  static void show(
    BuildContext context, {
    required String message,
    String? icon,
    ToastType toastType = ToastType.success,
    Duration toastDuration = const Duration(seconds: 3),
    double? top = 85,
    double? left,
    double? right,
    double? bottom,
  }) {
    final toastContext = Navigator.of(context, rootNavigator: true).context;
    final fToast = FToast()
      ..init(toastContext)
      ..removeQueuedCustomToasts()
      ..removeCustomToast();

    void dismissToast() => fToast.removeCustomToast();

    fToast.showToast(
      child: GestureDetector(
        onTap: dismissToast,
        behavior: HitTestBehavior.opaque,
        child: AppToastWidget(
          message: message,
          icon: icon,
          toastType: toastType,
        ),
      ),
      toastDuration: toastDuration,
      isDismissible: false,
      positionedToastBuilder: (context, child, gravity) {
        return Positioned(
          top: top != null ? max(16, top) : null,
          left: left ?? 0,
          right: right ?? 0,
          bottom: bottom,
          child: child,
        );
      },
    );
  }
}
