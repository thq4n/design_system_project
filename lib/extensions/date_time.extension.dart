part of 'extensions.dart';

extension DateOnlyCompare on DateTime {
  bool get isToday {
    return isSameDay(DateTime.now());
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isBeforeDate(DateTime other) {
    return !isSameDay(other) && isBefore(other);
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    bool? isUtc,
  }) {
    return ((isUtc ?? this.isUtc) ? DateTime.utc : DateTime.new)(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
    );
  }

  DateTime get startOfMinute {
    return DateTime(year, month, day, hour, minute, 0, 0);
  }

  DateTime get endOfMinute {
    return DateTime(year, month, day, hour, minute, 59, 999);
  }

  DateTime get startOfHour {
    return DateTime(year, month, day, hour, 0, 0, 0);
  }

  DateTime get endOfHour {
    return DateTime(year, month, day, hour, 59, 59, 999);
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get middle {
    return DateTime(year, month, day, 12);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  DateTime get startThisWeek {
    return subtract(Duration(days: weekday - 1)).startOfDay;
  }

  DateTime get endThisWeek {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  DateTime get startThisMonth {
    return DateTime(year, month, 1).startOfDay;
  }

  DateTime get endThisMonth {
    return DateTime(year, month + 1, 0).endOfDay;
  }

  DateTime get startPrevWeek {
    return subtract(Duration(days: weekday + 6)).startOfDay;
  }

  DateTime get endPrevWeek {
    return startPrevWeek.add(const Duration(days: 6)).endOfDay;
  }

  DateTime get prevMonth {
    return copyWith(month: month - 1);
  }

  DateTime get startPrevMonth {
    return prevMonth.copyWith(day: 1).startOfDay;
  }

  DateTime get endPrevMonth {
    return startPrevMonth
        .copyWith(month: month + 1)
        .subtract(const Duration(days: 1))
        .endOfDay;
  }
}

extension DateUtilsExtention on DateTime {
  String customFormat(
    List<String> format, {
    DateLocale locale = const EnglishDateLocale(),
  }) {
    return formatDate(
      toLocal(),
      format,
      locale: locale,
    );
  }

  /// **[mm, ' ', yyyy]**
  ///
  /// **01 2000**
  String toLocalmmyyyy() {
    return formatDate(
      toLocal(),
      DateTimeFormat().mmSpaceyyyy,
    );
  }

  /// **[dd, '/', mm, '/', yyyy]**
  ///
  /// **01/01/2000**
  String toLocalddmmyyyy() {
    return formatDate(
      toLocal(),
      DateTimeFormat().ddmmyyyy,
    );
  }

  /// **[dd, '/', mm, '/', yyyy]**
  ///
  /// **01/01/2000**
  String toddmmyyyy() {
    return formatDate(
      this,
      DateTimeFormat().ddmmyyyy,
    );
  }

  /// **[HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59 - 01/01/2000**
  String toLocalHHnnddmmyyyy() {
    return formatDate(
      toLocal(),
      DateTimeFormat().HHnnddmmyyyy,
    );
  }

  /// **[ dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]**
  ///
  /// **01/01/2000 10:59**
  String toLocalddmmyyyyHHnn() {
    return formatDate(
      toLocal(),
      DateTimeFormat().ddmmyyyyHHnn,
    );
  }

  /// **[ dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]**
  ///
  /// **01/01/2000 10:59:59**
  String toLocalddmmyyyyHHnnss() {
    return formatDate(
      toLocal(),
      DateTimeFormat().ddmmyyyyHHnnss,
    );
  }

  /// **[ yyyy, '/', mm, '/', dd, ' ', HH, ':', nn]**
  ///
  /// **01/01/2000 10:59**
  String toLocalyyyymmddHHnn() {
    return formatDate(
      toLocal(),
      DateTimeFormat().yyyymmddHHnn,
    );
  }

  /// **[HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59 - 01/01/2000**
  String toUTCHHnnddmmyyyy() {
    return formatDate(
      toUtc(),
      DateTimeFormat().HHnnddmmyyyy,
    );
  }

  /// **[yyyy, '/', mm, '/', dd]**
  ///
  /// **2000/01/01**
  String toUTCyyyymmdd() {
    return formatDate(
      toUtc(),
      DateTimeFormat().yyyymmdd,
    );
  }

  /// **[yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]**
  ///
  /// **2000-01-01 10:59:59**
  String toUTCyyyymmddHHnnss() {
    return formatDate(
      toUtc(),
      DateTimeFormat().yyyymmddHHnnss,
    );
  }

  /// **2000-01-01 10:59:59**
  String toLocalyyyymmddHHnnss() {
    return formatDate(
      toLocal(),
      DateTimeFormat().yyyymmddHHnnss,
    );
  }

  /// **[HH, ':', nn, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59, 01/01/2000**
  String toLocalHHnnddmmyyWithCommas() {
    return formatDate(
      toLocal(),
      DateTimeFormat().HHnnddmmyyWithCommas,
    );
  }

  /// **[yyyy, mm, dd, HH, nn, ss]**
  ///
  /// **20001225105959**
  String toLocalyyyymmddHHnnssWithoutSeparate() {
    return formatDate(
      toLocal(),
      DateTimeFormat().yyyymmddHHnnssWithoutSeparate,
    );
  }

  /// **[dd, mm, yyyy, HH, nn, ss]**
  ///
  /// **26072024105959**
  String toLocalddmmyyyyHHnnssWithoutSeparate() {
    return formatDate(
      toLocal(),
      DateTimeFormat().ddmmyyyyHHnnssWithoutSeparate,
    );
  }

  /// **[yyyy-mm]**
  ///
  /// **2024-07**
  String toLocalyyyyDashmm() {
    return formatDate(
      toLocal(),
      DateTimeFormat().yyyyDashmm,
    );
  }

  /// **[yyyy-mm-dd]**
  ///
  /// **2024-07-23**
  String toLocalyyyyDashmmDashdd() {
    return formatDate(
      toLocal(),
      DateTimeFormat().yyyyDashmmDashdd,
    );
  }

  String? timeago([String? locale]) {
    return tag_format.format(
      this,
      locale: locale,
      allowFromNow: true,
    );
  }

  /// **[HH, ':', nn]**
  ///
  /// **10:59**
  String toLocalTimeFormat() {
    return formatDate(
      toLocal(),
      DateTimeFormat().timeFormat,
    );
  }

  /// **[D, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **Tue, 01/01/2000**
  String toLocalDddmmyyyy({
    DateLocale locale = const EnglishDateLocale(),
  }) {
    return formatDate(
      toLocal(),
      DateTimeFormat().Dddmmyyyy,
      locale: locale,
    );
  }

  /// **[D, '\n', dd]**
  ///
  /// **Tue**
  ///
  /// **01**
  String toLocalDAbovedd({
    DateLocale locale = const EnglishDateLocale(),
  }) {
    return formatDate(
      toLocal(),
      DateTimeFormat().DAbovedd,
      locale: locale,
    );
  }

  /// **[dd-mm-yyyy]**
  ///
  /// **01-01-2000**
  String toLocalddDashmmDashyyyy({
    DateLocale locale = const EnglishDateLocale(),
  }) {
    return formatDate(
      toLocal(),
      DateTimeFormat().ddDashmmDashyyyy,
      locale: locale,
    );
  }

  /// **[HH, nn, ss]**
  ///
  /// **105959**
  String toLocalHHmmss({
    DateLocale locale = const EnglishDateLocale(),
  }) {
    return formatDate(
      toLocal(),
      DateTimeFormat().HHmmss,
      locale: locale,
    );
  }

  /// **[Tháng mm, yyyy]**
  /// **Tháng 01, 2024**
  String toLocalmmCommayyyy({
    DateLocale locale = const EnglishDateLocale(),
  }) {
    return formatDate(
      toLocal(),
      DateTimeFormat().mmCommayyyy,
      locale: locale,
    );
  }
}

/// Formats a date range with smart display logic.
///
/// If both dates are on the same day, displays:
/// **"20/12/2025 09:00 - 09:30"**
///
/// If dates are on different days, displays:
/// **"20/12/2025 09:00 - 21/12/2025 09:30"**
///
/// Returns "--" if either date is null.
///
/// Examples:
/// - Same day: `formatDateRange(DateTime(2025, 12, 20, 9, 0),
///   DateTime(2025, 12, 20, 9, 30))` returns "20/12/2025 09:00 - 09:30"
/// - Different days: `formatDateRange(DateTime(2025, 12, 20, 9, 0),
///   DateTime(2025, 12, 21, 9, 30))` returns "20/12/2025 09:00 - 21/12/2025
///   09:30"
/// - Null values: `formatDateRange(null, null)` returns "--"
String formatDateRange(DateTime? fromTime, DateTime? toTime) {
  if (fromTime == null || toTime == null) {
    return '--';
  }

  final fromLocal = fromTime.toLocal();
  final toLocal = toTime.toLocal();

  // Check if both dates are on the same day
  if (fromLocal.isSameDay(toLocal)) {
    // Same day: "20/12/2025 09:00 - 09:30"
    final datePart = fromLocal.toLocalddmmyyyy();
    final fromTimePart = fromLocal.toLocalTimeFormat();
    final toTimePart = toLocal.toLocalTimeFormat();
    return '$datePart $fromTimePart - $toTimePart';
  } else {
    // Different days: "20/12/2025 09:00 - 21/12/2025 09:30"
    final fromFormatted = fromLocal.toLocalddmmyyyyHHnn();
    final toFormatted = toLocal.toLocalddmmyyyyHHnn();
    return '$fromFormatted - $toFormatted';
  }
}
