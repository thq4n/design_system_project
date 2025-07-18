import 'package:flutter/services.dart';

/// A [TextInputFormatter] that allows only decimal numbers.
///
/// This formatter ensures that the input contains only digits and at most one
/// decimal point. It prevents multiple decimal points and non-numeric
/// characters.
class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    // Allow only digits and one decimal point
    final regex = RegExp(r'^\d*\.?\d*$');
    if (!regex.hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}
