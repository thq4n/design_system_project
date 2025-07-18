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
