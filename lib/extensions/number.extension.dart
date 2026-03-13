part of 'extensions.dart';

extension DoubleExt on double {
  String toStringAsMaxFixed(int fractionDigits) {
    return toStringAsFixed(fractionDigits);
  }
}

extension DistanceExt on double? {
  String get metterToKMDisplay {
    if (this == null) {
      return '';
    }
    return (this! / 1000).toStringAsFixed(1);
  }

  double toPrecision(int n) => double.parse((this ?? 0.0).toStringAsFixed(n));

  double truncateToDecimalPlaces(int fractionalDigits) {
    if (this == null) {
      return 0;
    }
    return (this! * pow(10, fractionalDigits)).truncate() /
        pow(10, fractionalDigits);
  }
}

extension DateTimeConverter on int? {
  String toFullDateTime() {
    if (this == null) {
      return '';
    }
    final dt = DateTime.fromMillisecondsSinceEpoch(this!);
    // Note: toLocalHHnnddmmyyyy() would need to be implemented
    // return dt.toLocalHHnnddmmyyyy();
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} ${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }
}

extension CurrencyExt on num? {
  String toAppCurrencyString({bool isWithSymbol = true, String? locale}) {
    // Note: NumberFormatUtils.getCurrencyNumberFormat() would
    // need to be implemented
    // return NumberFormatUtils.getCurrencyNumberFormat(
    //   isWithSymbol: isWithSymbol,
    // ).format(this ?? 0);
    final value = this ?? 0;
    final formatted = value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}${UtilsConstants.thousandSeparator}',
        );
    return isWithSymbol ? '$formatted đ' : formatted;
  }

  /// Formats this number for display using app locale (decimal: comma,
  /// thousands: dot). Uses [DecimalTextInputFormatter] so output is identical
  /// to what the formatter produces in text fields.
  String toAppFormattedDecimalNumberString({int? maxDecimalDigits}) {
    final n = this?.toDouble();
    if (n == null) return '';
    final raw = maxDecimalDigits != null && maxDecimalDigits >= 0
        ? n.toStringAsFixed(maxDecimalDigits)
        : n.toString();
    final withAppDecimal = raw.replaceFirst('.', UtilsConstants.decimalPoint);
    return DecimalTextInputFormatter(maxDecimalDigits: maxDecimalDigits)
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: withAppDecimal),
        )
        .text;
  }

  String toAppFormattedNumberString() {
    return toAppCurrencyString(isWithSymbol: false);
  }

  String displayMoney() {
    // Note: NumberFormatUtils().displayMoney() would need to be implemented
    // return NumberFormatUtils().displayMoney(this) ?? '';
    return toAppCurrencyString(isWithSymbol: true);
  }

  String toAppCurrencyStringWithPrefixSign({
    String? inititalSign,
    bool isWithSymbol = true,
    String? locale,
  }) {
    if (this == null) {
      return '';
    }
    final value = this!;
    final sign = inititalSign ?? (value >= 0 ? '+' : '');
    final formatted = value.abs().toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
    return '$sign$formatted${isWithSymbol ? ' đ' : ''}';
  }
}

extension WeightExt on int {
  String formatNumber({String prefix = ''}) {
    const pattern = r'(\d{1,3})(?=(\d{3})+(?!\d))';
    final regExp = RegExp(pattern);
    final mathFunc = (Match match) => '${match[1]},';
    return '${toString().replaceAllMapped(regExp, mathFunc)}$prefix';
  }
}

extension FileSize on int? {
  double get bytesToGB {
    return (this ?? 0) / 1073741824;
  }

  double get bytesToMb {
    return (this ?? 0) / 1048576;
  }

  double get bytesToKb {
    return (this ?? 0) / 1024;
  }
}
