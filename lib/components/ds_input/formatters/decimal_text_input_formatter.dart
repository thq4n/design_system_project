// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/services.dart';

import '../../../constants/constants.dart';
import '../../../utils/app_numeric_format_helpers.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final int? maxDecimalDigits;

  final double? min;

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

    final initialValidationRegEx = RegExp(
      r'^[\d' +
          RegExp.escape(UtilsConstants.thousandSeparatorSymbol) +
          RegExp.escape(UtilsConstants.decimalSymbol) +
          r']*$',
    );

    if (!initialValidationRegEx.hasMatch(newString)) {
      return oldValue;
    }

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
      final parts = oldString.split(UtilsConstants.decimalSymbol);
      newString = parts.isNotEmpty ? parts.first : '';
    }

    final data = newString.split(UtilsConstants.decimalSymbol);

    if (!newString.startsWith(UtilsConstants.decimalSymbol)) {
      var left = data.isNotEmpty ? data[0] : '0';
      final rawInteger =
          left.replaceAll(UtilsConstants.thousandSeparatorSymbol, '');
      final intVal = AppNumericFormatHelpers.parseToInt(rawInteger);
      left = AppNumericFormatHelpers.formatIntegerThousands(
        intVal,
        isWithSymbol: false,
      );
      data[0] = left;
      newString = data.join(UtilsConstants.decimalSymbol);
    }

    newString = regEx.stringMatch(newString) ?? oldValue.text;

    if (newString.contains(UtilsConstants.decimalSymbol)) {
      newString = newString.replaceFirst(RegExp(r'0*$'), '');
    }

    if (newString.endsWith(UtilsConstants.decimalSymbol)) {
      newString = '${newString}0';
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length - 1),
        composing: TextRange.collapsed(newString.length),
      );
    }

    if (newString.startsWith(UtilsConstants.decimalSymbol)) {
      newString = '0$newString';
      return TextEditingValue(
        text: newString,
        selection: const TextSelection.collapsed(offset: 1),
        composing: TextRange.collapsed(newString.length),
      );
    }

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
          final text = _formatClampedNumber(clamped);
          return TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
            composing: TextRange.empty,
          );
        }
      }
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
      composing: TextRange.collapsed(newString.length),
    );
  }

  String _formatClampedNumber(double clamped) {
    final raw = maxDecimalDigits != null && maxDecimalDigits! >= 0
        ? clamped.toStringAsFixed(maxDecimalDigits!)
        : clamped.toString();
    final withAppDecimal = raw.replaceFirst('.', UtilsConstants.decimalSymbol);
    return DecimalTextInputFormatter(maxDecimalDigits: maxDecimalDigits)
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: withAppDecimal),
        )
        .text;
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
