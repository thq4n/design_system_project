// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

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
