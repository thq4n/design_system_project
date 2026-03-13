import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';

class NumberFormatUtils {
  static const _locale = 'vi_vn';

  static NumberFormat getCurrencyNumberFormat({
    bool isWithSymbol = true,
  }) =>
      NumberFormat.currency(
        symbol: isWithSymbol ? ' đ' : '',
        customPattern:
            '''#${UtilsConstants.thousandSeparator}###${isWithSymbol ? '\u00a4' : ''}''',
        decimalDigits: 0,
      );

  final NumberFormat _numberFormat = NumberFormat.decimalPattern(_locale);

  String? displayMoney(num? amount) {
    if (amount == null) {
      return null;
    }
    return amount.toCurrencyString(
      mantissaLength: 0,
      trailingSymbol: 'đ',
      useSymbolPadding: true,
      thousandSeparator: ThousandSeparator.Period,
    );
  }

  String? decimalFormat(num? number) {
    return _numberFormat.format(number);
  }

  double? parseDouble(String? string) {
    if (string == null || string.isEmpty == true) {
      return null;
    }
    return _numberFormat.parse(string).toDouble();
  }

  /// Formats a number for display using app locale constants
  /// ([UtilsConstants.decimalPoint], [UtilsConstants.thousandSeparator]).
  /// Use this as the single source of truth for decimal number display so
  /// that changing locale/constants in one place keeps the app consistent.
  ///
  /// [value] The number to format; null returns ''.
  /// [maxDecimalDigits] Optional cap on fractional digits; trailing zeros are
  /// removed.
  static String formatDecimalForDisplay(num? value, {int? maxDecimalDigits}) {
    if (value == null) return '';
    final n = value.toDouble();
    final isNegative = n < 0;
    final absN = n.abs();

    String intPartStr;
    String fracPartStr;

    if (maxDecimalDigits != null && maxDecimalDigits >= 0) {
      final fixed = absN.toStringAsFixed(maxDecimalDigits);
      final parts = fixed.split('.');
      intPartStr = parts[0];
      final frac = parts.length > 1 ? parts[1] : '';
      fracPartStr = frac.replaceAll(RegExp(r'0+$'), '');
    } else {
      final s = absN.toString();
      if (s.contains('e') || s.contains('E')) {
        final fixed = absN.toStringAsFixed(10);
        final parts = fixed.split('.');
        intPartStr = parts[0];
        fracPartStr = (parts.length > 1 ? parts[1] : '').replaceAll(RegExp(r'0+$'), '');
      } else {
        final parts = s.split('.');
        intPartStr = parts[0];
        fracPartStr = parts.length > 1 ? parts[1] : '';
      }
    }

    final intFormatted = intPartStr.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}${UtilsConstants.thousandSeparator}',
    );

    final formatted = fracPartStr.isEmpty
        ? intFormatted
        : '$intFormatted${UtilsConstants.decimalPoint}$fracPartStr';

    return isNegative ? '-$formatted' : formatted;
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final value = newValue.text.intNumber;

    final newText = value.toAppCurrencyString(isWithSymbol: false);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class UsernameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue;
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  final int? maxDecimalDigits;

  DecimalTextInputFormatter({this.maxDecimalDigits});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldString = oldValue.text;
    var newString = newValue.text;

    // Validate that the new input contains only allowed characters
    final initialValidationRegEx = RegExp(
      r'^[\d' +
          RegExp.escape(UtilsConstants.thousandSeparator) +
          RegExp.escape(UtilsConstants.decimalPoint) +
          r']*$',
    );

    if (!initialValidationRegEx.hasMatch(newString)) {
      // If input contains invalid characters, keep the old value
      return oldValue;
    }

    // Proceed with the original formatting logic
    // Escape thousand separator so "." matches literal period, not any character
    final regEx = RegExp(
      r'^\d{1,3}('
      '${RegExp.escape(UtilsConstants.thousandSeparator)}'
      r'\d{3})*(\'
      '${UtilsConstants.decimalPoint}'
      r'\d'
      '${(maxDecimalDigits ?? 0) > 0 ? '{0,$maxDecimalDigits}' : '*'}'
      r')?$',
    );

    if (!newString.contains(UtilsConstants.decimalPoint) &&
        oldString.contains(UtilsConstants.decimalPoint)) {
      newString =
          oldString.split(UtilsConstants.decimalPoint).firstOrNull ?? '';
    }

    final data = newString.split(UtilsConstants.decimalPoint);

    // Process integer part (before the decimal point)
    // Strip thousand separators before parsing so "25.555" -> 25555, not 25
    if (!newString.startsWith(UtilsConstants.decimalPoint)) {
      var left = data.isNotEmpty ? data[0] : '0';
      final rawInteger = left.replaceAll(UtilsConstants.thousandSeparator, '');
      left = rawInteger.intNumber.toAppCurrencyString(isWithSymbol: false);
      data[0] = left;
      newString = data.join(UtilsConstants.decimalPoint);
    }

    // Ensure the input matches the desired pattern,
    // otherwise revert to old value
    newString = regEx.stringMatch(newString) ?? oldValue.text;

    // Remove trailing zeros
    if (newString.contains(UtilsConstants.decimalPoint)) {
      newString = newString.replaceFirst(RegExp(r'0*$'), '');
    }

    // Handle input ending with a decimal point
    if (newString.endsWith(UtilsConstants.decimalPoint)) {
      newString = '${newString}0';
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length - 1),
        composing: TextRange.collapsed(newString.length),
      );
    }

    // Handle input starting with a decimal point
    if (newString.startsWith(UtilsConstants.decimalPoint)) {
      newString = '0$newString';
      return TextEditingValue(
        text: newString,
        selection: const TextSelection.collapsed(offset: 1),
        composing: TextRange.collapsed(newString.length),
      );
    }

    // Final return with proper formatting
    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
      composing: TextRange.collapsed(newString.length),
    );
  }
}

class IntegerTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Regular expression to match integer values only
    final regEx = RegExp('^[\\d${UtilsConstants.thousandSeparator}]*\$');

    var newString = newValue.text;

    // If the new string matches the regex, keep it;
    // Otherwise, revert to old value
    newString = regEx.stringMatch(newString) ?? oldValue.text;

    // Remove leading zeros if present
    newString = newString.intNumber.toAppCurrencyString(isWithSymbol: false);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
      composing: TextRange.collapsed(newString.length),
    );
  }
}

class SizeAndWeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Regular expression to match numbers with up to 3 decimal places
    final regEx = RegExp(r'^\d*\.?\d{0,3}$');

    var newString = newValue.text;

    // If the new string matches the regex, keep it;
    // Otherwise, revert to old value
    newString = regEx.stringMatch(newString) ?? oldValue.text;

    // If the new string starts with '.', prepend '0'
    if (newString.startsWith('.')) {
      newString = '0$newString';
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
