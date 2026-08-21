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

  String get _thousand => UtilsConstants.thousandSeparatorSymbol;

  String get _decimal => UtilsConstants.decimalSymbol;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
        composing: TextRange.empty,
      );
    }

    final allowed = RegExp(
      r'^[\d' + RegExp.escape(_thousand) + RegExp.escape(_decimal) + r']*$',
    );
    if (!allowed.hasMatch(newValue.text)) {
      return oldValue;
    }

    final decimalIndex = _decimalSeparatorIndex(oldValue, newValue);
    if (decimalIndex == null) {
      return oldValue;
    }

    final text = newValue.text;
    final integerRaw =
        decimalIndex >= 0 ? text.substring(0, decimalIndex) : text;
    final fractionRaw =
        decimalIndex >= 0 ? text.substring(decimalIndex + 1) : '';
    if (fractionRaw.contains(_thousand) || fractionRaw.contains(_decimal)) {
      return oldValue;
    }

    final integerDigits = integerRaw.replaceAll(_thousand, '');
    final fractionDigits = fractionRaw;
    if (!_digitsOnly.hasMatch(integerDigits) ||
        !_digitsOnly.hasMatch(fractionDigits)) {
      return oldValue;
    }
    if (integerDigits.isEmpty && fractionDigits.isEmpty && decimalIndex < 0) {
      return oldValue;
    }

    if (maxDecimalDigits != null &&
        maxDecimalDigits! >= 0 &&
        fractionDigits.length > maxDecimalDigits!) {
      return oldValue;
    }

    final hasDecimal = decimalIndex >= 0;
    final normalizedInteger = _normalizeIntegerDigits(
      integerDigits,
      hasDecimal: hasDecimal,
    );
    if (normalizedInteger.isEmpty) {
      return oldValue;
    }

    final formattedInteger = _formatThousands(normalizedInteger);
    final formatted = hasDecimal
        ? '$formattedInteger$_decimal$fractionDigits'
        : formattedInteger;

    final parsed = AppNumericFormatHelpers.parseToDouble(formatted);
    if (parsed != null && max != null && parsed > max!) {
      return oldValue;
    }

    var significantBeforeCursor = _countSignificantBeforeCursor(
      text: text,
      cursor: newValue.selection.baseOffset,
      decimalIndex: decimalIndex,
    );
    if (integerDigits.isEmpty && hasDecimal) {
      significantBeforeCursor += 1;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: _mapCursor(formatted, significantBeforeCursor),
      ),
      composing: TextRange.empty,
    );
  }

  static final RegExp _digitsOnly = RegExp(r'^\d*$');

  int? _decimalSeparatorIndex(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final commaIndex = text.indexOf(_decimal);
    if (commaIndex >= 0) {
      if (text.indexOf(_decimal, commaIndex + 1) >= 0) {
        return null;
      }
      return commaIndex;
    }

    final extraDotIndex = _indexOfInsertedDot(oldValue.text, text);
    if (extraDotIndex != null) {
      return extraDotIndex;
    }

    if (oldValue.text.isEmpty || _isFullReplacement(oldValue)) {
      return _decimalIndexFromPastedText(text);
    }

    return -1;
  }

  int? _indexOfInsertedDot(String oldText, String newText) {
    if (newText.contains(_decimal) ||
        newText.length != oldText.length + 1 ||
        _digitsOf(oldText) != _digitsOf(newText)) {
      return null;
    }
    for (var i = 0; i < newText.length; i++) {
      if (i >= oldText.length || newText[i] != oldText[i]) {
        return newText[i] == _thousand ? i : null;
      }
    }
    return null;
  }

  String _digitsOf(String text) {
    return text.replaceAll(_thousand, '').replaceAll(_decimal, '');
  }

  int _decimalIndexFromPastedText(String text) {
    final thousandOnly = RegExp(
      r'^\d{1,3}(' + RegExp.escape(_thousand) + r'\d{3})+$',
    );
    if (thousandOnly.hasMatch(text) || !text.contains(_thousand)) {
      return -1;
    }
    return text.lastIndexOf(_thousand);
  }

  bool _isFullReplacement(TextEditingValue oldValue) {
    final selection = oldValue.selection;
    return selection.isValid &&
        !selection.isCollapsed &&
        selection.start == 0 &&
        selection.end == oldValue.text.length;
  }

  String _normalizeIntegerDigits(
    String digits, {
    required bool hasDecimal,
  }) {
    if (digits.isEmpty) {
      return hasDecimal ? '0' : '';
    }
    return digits.replaceFirst(RegExp(r'^0+(?=\d)'), '');
  }

  String _formatThousands(String digits) {
    return digits.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}$_thousand',
    );
  }

  int _countSignificantBeforeCursor({
    required String text,
    required int cursor,
    required int decimalIndex,
  }) {
    final end = cursor.clamp(0, text.length);
    var count = 0;
    for (var i = 0; i < end; i++) {
      if (i == decimalIndex) {
        count++;
        continue;
      }
      final character = text[i];
      if (character == _thousand) {
        continue;
      }
      if (_digit.hasMatch(character)) {
        count++;
      }
    }
    return count;
  }

  static final RegExp _digit = RegExp(r'\d');

  int _mapCursor(String formatted, int significantBeforeCursor) {
    if (significantBeforeCursor <= 0) {
      return 0;
    }
    var seen = 0;
    for (var i = 0; i < formatted.length; i++) {
      if (formatted[i] == _thousand) {
        continue;
      }
      seen++;
      if (seen >= significantBeforeCursor) {
        return i + 1;
      }
    }
    return formatted.length;
  }
}
