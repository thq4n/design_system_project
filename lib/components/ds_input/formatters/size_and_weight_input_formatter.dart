import 'package:flutter/services.dart';

class SizeAndWeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regEx = RegExp(r'^\d*\.?\d{0,3}$');

    var newString = newValue.text;

    newString = regEx.stringMatch(newString) ?? oldValue.text;

    if (newString.startsWith('.')) {
      newString = '0$newString';
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
