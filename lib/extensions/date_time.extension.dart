part of 'extensions.dart';

extension DateOnlyCompare on DateTime {
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
