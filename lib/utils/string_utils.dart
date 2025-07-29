import 'package:flutter/material.dart';

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

  /// Formats Vietnamese phone number with proper spacing
  ///
  /// Examples:
  /// - "0909090909" -> "+84 909 090 909"
  /// - "84909090909" -> "+84 909 090 909"
  /// - "942003360" -> "+84 942 003 360"
  String get formatedPhoneNumberString {
    if (isEmpty) {
      return this;
    }

    // Remove any non-digit characters
    final cleanNumber = replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.isEmpty) {
      return this;
    }

    // Handle Vietnamese phone number patterns
    String formattedNumber;

    // If starts with 84 (country code), remove it
    if (cleanNumber.startsWith('84') && cleanNumber.length >= 11) {
      formattedNumber = cleanNumber.substring(2);
    } else if (cleanNumber.startsWith('0') && cleanNumber.length == 10) {
      // Remove leading 0 for national format
      formattedNumber = cleanNumber.substring(1);
    } else if (cleanNumber.length == 9 && !cleanNumber.startsWith('0')) {
      // 9-digit number without leading 0
      formattedNumber = cleanNumber;
    } else {
      // Return original if doesn't match Vietnamese patterns
      return this;
    }

    // Format with international format: +84 xxx xxx xxx
    if (formattedNumber.length == 9) {
      return '''+84 ${formattedNumber.substring(0, 3)} ${formattedNumber.substring(3, 6)} ${formattedNumber.substring(6)}''';
    }

    // Return formatted number if it doesn't match expected length
    return formattedNumber;
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

  String get capitalize {
    return this[0].toUpperCase() + substring(1);
  }

  String get toImageUrl {
    debugPrint('FETCH IMAGE FROM: $this');
    return this;
  }

  String get toVideoUrl {
    debugPrint('FETCH VIDEO FROM: $this');
    return this;
  }

  String get toRawString {
    return this;
  }

  bool isPhoneNumberValid() {
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
}

extension NullableStringDataHelper on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
