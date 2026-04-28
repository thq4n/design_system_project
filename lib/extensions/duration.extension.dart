part of 'extensions.dart';

extension DurationExt on Duration? {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String? get hhmm {
    if (this == null) {
      return null;
    }
    final twoDigitMinutes = twoDigits(this!.inMinutes.remainder(60));
    return '${twoDigits(this!.inHours)}:$twoDigitMinutes';
  }

  String? get hhmmss {
    if (this == null) {
      return null;
    }
    return toString().split('.').first.padLeft(8, '0');
  }
}
