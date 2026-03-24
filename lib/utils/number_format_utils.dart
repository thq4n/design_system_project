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
            '''#${UtilsConstants.thousandSeparatorSymbol}###${isWithSymbol ? '\u00a4' : ''}''',
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
  /// ([UtilsConstants.decimalSymbol], [UtilsConstants.thousandSeparatorSymbol]).
  /// Use this as the single source of truth for decimal number display so
  /// that changing locale/constants in one place keeps the app consistent.
  ///
  /// [value] The number to format; null returns ''.
  /// [maxDecimalDigits] Optional cap on fractional digits; trailing zeros are
  /// removed.
  static String formatDecimalForDisplay(num? value, {int? maxDecimalDigits}) {
    if (value == null) {
      return '';
    }
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
        fracPartStr =
            (parts.length > 1 ? parts[1] : '').replaceAll(RegExp(r'0+$'), '');
      } else {
        final parts = s.split('.');
        intPartStr = parts[0];
        fracPartStr = parts.length > 1 ? parts[1] : '';
      }
    }

    final intFormatted = intPartStr.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}${UtilsConstants.thousandSeparatorSymbol}',
    );

    final formatted = fracPartStr.isEmpty
        ? intFormatted
        : '$intFormatted${UtilsConstants.decimalSymbol}$fracPartStr';

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

  /// Giới hạn giá trị tối thiểu (ví dụ: 0).
  final double? min;

  /// Giới hạn giá trị tối đa (ví dụ: 100).
  final double? max;

  DecimalTextInputFormatter({
    this.maxDecimalDigits,
    this.min,
    this.max,
  }) : assert(
          min == null || max == null || min <= max,
          'min must be less than or equal to max',
        );

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
          RegExp.escape(UtilsConstants.thousandSeparatorSymbol) +
          RegExp.escape(UtilsConstants.decimalSymbol) +
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
      '${RegExp.escape(UtilsConstants.thousandSeparatorSymbol)}'
      r'\d{3})*(\'
      '${UtilsConstants.decimalSymbol}'
      r'\d'
      '${(maxDecimalDigits ?? 0) > 0 ? '{0,$maxDecimalDigits}' : '*'}'
      r')?$',
    );

    if (!newString.contains(UtilsConstants.decimalSymbol) &&
        oldString.contains(UtilsConstants.decimalSymbol)) {
      newString =
          oldString.split(UtilsConstants.decimalSymbol).firstOrNull ?? '';
    }

    final data = newString.split(UtilsConstants.decimalSymbol);

    // Process integer part (before the decimal point)
    // Strip thousand separators before parsing so "25.555" -> 25555, not 25
    if (!newString.startsWith(UtilsConstants.decimalSymbol)) {
      var left = data.isNotEmpty ? data[0] : '0';
      final rawInteger =
          left.replaceAll(UtilsConstants.thousandSeparatorSymbol, '');
      left = rawInteger.intNumber.toAppCurrencyString(isWithSymbol: false);
      data[0] = left;
      newString = data.join(UtilsConstants.decimalSymbol);
    }

    // Ensure the input matches the desired pattern,
    // otherwise revert to old value
    newString = regEx.stringMatch(newString) ?? oldValue.text;

    // Remove trailing zeros
    if (newString.contains(UtilsConstants.decimalSymbol)) {
      newString = newString.replaceFirst(RegExp(r'0*$'), '');
    }

    // Handle input ending with a decimal point
    if (newString.endsWith(UtilsConstants.decimalSymbol)) {
      newString = '${newString}0';
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length - 1),
        composing: TextRange.collapsed(newString.length),
      );
    }

    // Handle input starting with a decimal point
    if (newString.startsWith(UtilsConstants.decimalSymbol)) {
      newString = '0$newString';
      return TextEditingValue(
        text: newString,
        selection: const TextSelection.collapsed(offset: 1),
        composing: TextRange.collapsed(newString.length),
      );
    }

    // Áp dụng giới hạn min/max nếu có
    if (min != null || max != null) {
      final value = _parseFormattedDecimal(newString);
      if (value != null) {
        var clamped = value;
        if (min != null && clamped < min!) {
          clamped = min!;
        }
        if (max != null && clamped > max!) {
          clamped = max!;
        }
        if (clamped != value) {
          final text = clamped.toAppFormattedDecimalNumberString(
            maxDecimalDigits: maxDecimalDigits,
          );
          return TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
            composing: TextRange.empty,
          );
        }
      }
    }

    // Final return with proper formatting
    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
      composing: TextRange.collapsed(newString.length),
    );
  }

  static double? _parseFormattedDecimal(String s) {
    if (s.isEmpty) {
      return null;
    }
    final raw = s
        .replaceAll(UtilsConstants.thousandSeparatorSymbol, '')
        .replaceAll(UtilsConstants.decimalSymbol, '.');
    return double.tryParse(raw);
  }
}

class IntegerTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Regular expression to match integer values only
    final regEx = RegExp('^[\\d${UtilsConstants.thousandSeparatorSymbol}]*\$');

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
