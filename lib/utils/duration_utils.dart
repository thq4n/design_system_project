import 'package:flutter/material.dart';

extension DurationUtils on String {
  Duration parseDuration() {
    final duration3Regex = RegExp(r'\d+:\d+:\d+(\.\d+)?');
    final duration2Regex = RegExp(r'\d+:\d+(\.\d+)?');

    var hours = 0;
    var minutes = 0;
    var micros = 0;
    String? formated;
    if (duration3Regex.hasMatch(this)) {
      formated = duration3Regex.firstMatch(this)!.group(0);
    } else if (duration2Regex.hasMatch(this)) {
      formated = duration2Regex.firstMatch(this)!.group(0);
    }
    if (formated?.isEmpty ?? true) {
      return Duration.zero;
    }
    final parts = formated!.split(':');
    try {
      if (parts.isNotEmpty) {
        hours = int.parse(parts.first);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[1]);
      }
      if (parts.length > 2) {
        micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      }
      return Duration(hours: hours, minutes: minutes, microseconds: micros);
    } catch (_) {
      return Duration.zero;
    }
  }
}
