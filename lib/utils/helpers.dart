// lib/utils/helpers.dart
import 'package:flutter/material.dart';

class Helpers {
  static double adjustFontSize(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (width < 360) {
      return 12.0;
    } else if (width < 480) {
      return 14.0;
    } else {
      return 16.0;
    }
  }
}

extension ObjectExt<T> on T? {
  R let<R>(R Function(T? it) op) => op(this);
}

extension StringDataHelper on String {
  bool get isEmailValid {
    return RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(this);
  }

  bool get isPasswordValid {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(this);
  }

  bool get isVietnamPhoneNumberValid {
    return RegExp(r'^(84|0[3|5|7|8|9])+([0-9]{8})$').hasMatch(this);
  }

  bool get hasLowerCase {
    return RegExp(r'^(?=.*[a-z])').hasMatch(this);
  }

  bool get hasUpperCase {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(this);
  }

  bool get hasNumber {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(this);
  }

  bool get hasSpecialCharacter {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(this);
  }

  bool get hasMinLength {
    return RegExp(r'^(?=.{8,})').hasMatch(this);
  }

  String get capilitize {
    return this[0].toUpperCase() + substring(1);
  }

  String get imageURL {
    debugPrint('FETCH IMAGE FROM: $this');
    return this;
  }

  String get videoURL {
    debugPrint('FETCH VIDEO FROM: $this');
    return this;
  }

  String get rawString {
    return this;
  }

  bool isValidPhoneNumber() {
    if (isEmpty) {
      return false;
    }

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  bool isEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool get isValidPassword {
    final length = this.length;
    final hasLetter = contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = contains(RegExp(r'[0-9]'));
    final isValid = (length >= 8) && hasLetter && hasNumber;
    return isValid;
  }

  bool get isValidStaffPassword {
    final length = this.length;
    final hasLowerCase = contains(RegExp(r'[a-z]'));
    final hasUpperCase = contains(RegExp(r'[A-Z]'));
    final hasSpecialChar = contains(RegExp(r'[.,*?!@#\$&*~]'));
    final isValid =
        (length >= 6) && hasLowerCase && hasUpperCase && hasSpecialChar;
    return isValid;
  }

  bool get isLocalUrl {
    return startsWith('/') ||
        startsWith('file://') ||
        (length > 1 && substring(1).startsWith(':\\'));
  }

  bool get isUrl => Uri.parse(this).isAbsolute;

  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String capitalizeFirstOfEach() {
    return replaceAllMapped(RegExp(r'[^\s.,;!?":/()\[\]{}|\\]+'), (match) {
      if (match.group(0) == null) {
        return '';
      }
      return '${match.group(0)?.capitalizeFirst()}';
    });
  }

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
