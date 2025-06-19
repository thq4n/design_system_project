// lib/utils/helpers.dart
import 'package:flutter/material.dart';

class Helpers {
  static double adjustFontSize(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (width < 360) {
      return 12.0;
    } else if (width < 480) {
      return 14.0;
    } else {
      return 16.0;
    }
  }
}
