import 'package:flutter/services.dart';

import '../../../utils/app_numeric_format_helpers.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final value = AppNumericFormatHelpers.parseToInt(newValue.text);
    final newText = AppNumericFormatHelpers.formatIntegerThousands(
      value,
      isWithSymbol: false,
    );

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
