import 'package:flutter/services.dart';

class UsernameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text =
        newValue.text.replaceAll(' ', '-').replaceAll('--', '-').toUpperCase();
    if (text == newValue.text) {
      return newValue;
    }
    final len = text.length;
    return newValue.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: newValue.selection.baseOffset.clamp(0, len),
        extentOffset: newValue.selection.extentOffset.clamp(0, len),
      ),
      composing: TextRange.empty,
    );
  }
}
