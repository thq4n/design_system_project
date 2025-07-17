import 'package:flutter/material.dart';

extension BuildContextUtils on BuildContext {
  double get adjustFontSize {
    final double width = MediaQuery.of(this).size.width;
    if (width < 360) {
      return 12.0;
    } else if (width < 480) {
      return 14.0;
    } else {
      return 16.0;
    }
  }
}
