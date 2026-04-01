import '../constants/constants.dart';

abstract final class AppNumericFormatHelpers {
  AppNumericFormatHelpers._();

  static String? normalizeForParse(String? text) {
    if (text == null) {
      return null;
    }
    return text
        .replaceAll(UtilsConstants.thousandSeparatorSymbol, '')
        .replaceAll(
          UtilsConstants.decimalSymbol,
          UtilsConstants.languageDecimalSymbol,
        );
  }

  static double? parseToDouble(String? text) {
    final n = normalizeForParse(text);
    if (n == null || n.isEmpty) {
      return null;
    }
    return double.tryParse(n);
  }

  static int? parseToInt(String? text) => parseToDouble(text)?.toInt();

  static String formatIntegerThousands(num? value, {bool isWithSymbol = true}) {
    final v = value ?? 0;
    final formatted = v.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}${UtilsConstants.thousandSeparatorSymbol}',
    );
    return isWithSymbol ? '$formatted đ' : formatted;
  }
}
