import 'package:flutter/material.dart';

class TransparentInkWell extends InkWell {
  TransparentInkWell({
    required Widget? child,
    required Function()? onTap,
  }) : super(
          child: child,
          onTap: onTap,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
        );
}
