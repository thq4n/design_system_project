import 'package:flutter/services.dart';

import '../../../constants/constants.dart';
import '../../../utils/app_numeric_format_helpers.dart';

class IntegerTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regEx = RegExp('^[\\d${UtilsConstants.thousandSeparatorSymbol}]*\$');

    var newString = newValue.text;

    newString = regEx.stringMatch(newString) ?? oldValue.text;

    final intVal = AppNumericFormatHelpers.parseToInt(newString);
    newString = AppNumericFormatHelpers.formatIntegerThousands(
      intVal,
      isWithSymbol: false,
    );

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
      composing: TextRange.collapsed(newString.length),
    );
  }
}
