import 'package:flutter/services.dart';

/// A [TextInputFormatter] that allows only integer numbers.
///
/// This formatter ensures that the input contains only digits.
/// It prevents decimal points and non-numeric characters.
class IntegerTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    // Allow only digits
    final regex = RegExp(r'^\d*$');
    if (!regex.hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}
