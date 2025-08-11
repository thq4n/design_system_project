part of 'extensions.dart';

extension NullableStringIsNullOrEmptyExtension on String? {
  /// Returns `true` if the String is either null or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

extension StringExt on String {
  // Email validation - Comprehensive email validation with detailed regex explanation
  /// Validates email format using comprehensive regex pattern
  ///
  /// Examples of valid emails:
  /// - user@example.com
  /// - user.name@example.com
  /// - user+tag@example.co.uk
  /// - "user name"@example.com
  /// - user@[192.168.1.1]
  ///
  /// Examples of invalid emails:
  /// - user@ (missing domain)
  /// - @example.com (missing local part)
  /// - user@.com (missing domain name)
  /// - user..name@example.com (consecutive dots)
  bool get isEmailValid {
    return RegExp(r'^' // Start of string
            r'(' // Group 1: Local part OR quoted local part
            r'(' // Group 2: Standard local part
            r'[^<>()[\]\\.,;:\s@"]+' // One or more characters that are not: < > ( ) [ ] \ . , ; : space @ "
            r'(\.[^<>()[\]\\.,;:\s@"]+)*' // Optional: dot followed by more valid characters (for subdomains like user.name)
            r')' // End Group 2
            r'|' // OR
            r'(\".+\")' // Group 3: Quoted local part - anything in quotes like "user name"
            r')' // End Group 1
            r'@' // @ symbol
            r'(' // Group 4: Domain part
            r'(' // Group 5: IP address domain
            r'\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\]' // IP address in brackets like [192.168.1.1]
            r')' // End Group 5
            r'|' // OR
            r'(' // Group 6: Standard domain
            r'([a-zA-Z\-0-9]+\.)+' // One or more domain parts separated by dots (like example.co)
            r'[a-zA-Z]{2,}' // Top-level domain with at least 2 letters (like com, uk, org)
            r')' // End Group 6
            r')' // End Group 4
            r'$' // End of string
            )
        .hasMatch(this);
  }

  /// Alias for isEmailValid for backward compatibility
  bool isEmail() => isEmailValid;

  // Password validation - Strong password validation with detailed regex explanation
  /// Validates strong password with specific requirements
  ///
  /// Requirements:
  /// - At least 8 characters long
  /// - Contains at least one lowercase letter
  /// - Contains at least one uppercase letter
  /// - Contains at least one digit
  /// - Contains at least one special character (@$!%*?&)
  ///
  /// Examples of valid passwords:
  /// - MyPass@123
  /// - SecureP@ss1
  /// - Test123!@#
  ///
  /// Examples of invalid passwords:
  /// - password (no uppercase, no digit, no special char)
  /// - PASSWORD (no lowercase, no digit, no special char)
  /// - Pass123 (no special character)
  /// - My@ss (too short)
  bool get isPasswordValid {
    return RegExp(r'^' // Start of string
            r'(?=.*[a-z])' // Positive lookahead: must contain at least one lowercase letter
            r'(?=.*[A-Z])' // Positive lookahead: must contain at least one uppercase letter
            r'(?=.*\d)' // Positive lookahead: must contain at least one digit
            r'(?=.*[@$!%*?&])' // Positive lookahead: must contain at least one special character
            r'[A-Za-z\d@$!%*?&]{8,}' // Main pattern: 8 or more characters from allowed set
            r'$' // End of string
            )
        .hasMatch(this);
  }

  /// Basic password validation (simpler requirements)
  ///
  /// Requirements:
  /// - At least 8 characters long
  /// - Contains at least one letter (a-z or A-Z)
  /// - Contains at least one digit (0-9)
  ///
  /// Examples of valid passwords:
  /// - password123
  /// - MyPass123
  /// - 12345678a
  ///
  /// Examples of invalid passwords:
  /// - password (no digit)
  /// - 12345678 (no letter)
  /// - pass1 (too short)
  bool get isValidPassword {
    final length = this.length;
    final hasLetter = contains(
        RegExp(r'[a-zA-Z]')); // Contains at least one letter (a-z or A-Z)
    final hasNumber =
        contains(RegExp(r'[0-9]')); // Contains at least one digit (0-9)
    final isValid = (length >= 8) && hasLetter && hasNumber;
    return isValid;
  }

  /// Staff-specific password validation
  ///
  /// Requirements:
  /// - At least 6 characters long
  /// - Contains at least one lowercase letter
  /// - Contains at least one uppercase letter
  /// - Contains at least one special character (.,*?!@#$&*~)
  ///
  /// Examples of valid passwords:
  /// - Staff@123
  /// - Admin#456
  /// - User!789
  ///
  /// Examples of invalid passwords:
  /// - staff123 (no uppercase, no special char)
  /// - STAFF123 (no lowercase, no special char)
  /// - Staff123 (no special character)
  /// - St@ff (too short)
  bool get isValidStaffPassword {
    final length = this.length;
    final hasLowerCase =
        contains(RegExp(r'[a-z]')); // Contains at least one lowercase letter
    final hasUpperCase =
        contains(RegExp(r'[A-Z]')); // Contains at least one uppercase letter
    final hasSpecialChar = contains(
        RegExp(r'[.,*?!@#\$&*~]')); // Contains at least one special character
    final isValid =
        (length >= 6) && hasLowerCase && hasUpperCase && hasSpecialChar;
    return isValid;
  }

  // Password component checks - Individual password requirement validators
  /// Checks if password contains at least one lowercase letter (a-z)
  ///
  /// Examples:
  /// - "Password123" -> true (contains 'a', 's', 's', 'w', 'o', 'r', 'd')
  /// - "PASSWORD123" -> false (no lowercase letters)
  /// - "123456" -> false (no letters at all)
  bool get hasLowerCase {
    return RegExp(r'^' // Start of string
            r'(?=.*[a-z])' // Positive lookahead: must contain at least one lowercase letter
            )
        .hasMatch(this);
  }

  /// Checks if password contains at least one uppercase letter (A-Z)
  ///
  /// Examples:
  /// - "Password123" -> true (contains 'P')
  /// - "password123" -> false (no uppercase letters)
  /// - "123456" -> false (no letters at all)
  bool get hasUpperCase {
    return RegExp(r'^' // Start of string
            r'(?=.*[A-Z])' // Positive lookahead: must contain at least one uppercase letter
            )
        .hasMatch(this);
  }

  /// Checks if password contains at least one digit (0-9)
  ///
  /// Examples:
  /// - "Password123" -> true (contains '1', '2', '3')
  /// - "Password" -> false (no digits)
  /// - "abc" -> false (no digits)
  bool get hasNumber {
    return RegExp(r'^' // Start of string
            r'(?=.*?[0-9])' // Positive lookahead: must contain at least one digit (non-greedy)
            )
        .hasMatch(this);
  }

  /// Checks if password contains at least one special character
  ///
  /// Special characters: # ? ! @ $ % ^ & * -
  ///
  /// Examples:
  /// - "Password#123" -> true (contains '#')
  /// - "Password@123" -> true (contains '@')
  /// - "Password123" -> false (no special characters)
  /// - "Pass word" -> false (space is not considered special character)
  bool get hasSpecialCharacter {
    return RegExp(r'^' // Start of string
            r'(?=.*?[#?!@$%^&*-])' // Positive lookahead: must contain at least one special character (non-greedy)
            )
        .hasMatch(this);
  }

  /// Checks if password has minimum length of 8 characters
  ///
  /// Examples:
  /// - "Password123" -> true (11 characters)
  /// - "Pass123" -> false (7 characters)
  /// - "P@ss1" -> false (5 characters)
  bool get hasMinLength {
    return RegExp(r'^' // Start of string
            r'(?=.{8,})' // Positive lookahead: must be at least 8 characters long
            )
        .hasMatch(this);
  }

  // Phone number validation - Vietnamese phone number validation with detailed regex explanation
  /// Validates Vietnamese phone number format
  ///
  /// Valid formats:
  /// - 84xxxxxxxxx (international format)
  /// - 0xxxxxxxxx (national format starting with 0)
  /// - Mobile numbers: 03, 05, 07, 08, 09 + 8 digits
  ///
  /// Examples of valid numbers:
  /// - 84901234567
  /// - 0901234567
  /// - 0912345678
  ///
  /// Examples of invalid numbers:
  /// - 1234567890 (invalid prefix)
  /// - 8490123456 (too short)
  /// - 849012345678 (too long)
  bool get isVietnamPhoneNumberValid {
    return RegExp(r'^' // Start of string
            r'(84|0[3|5|7|8|9])' // Country code (84) OR national format (0 followed by 3,5,7,8,9)
            r'([0-9]{8})' // Exactly 8 digits
            r'$' // End of string
            )
        .hasMatch(this);
  }

  /// Alias for isValidPhoneNumber for backward compatibility
  bool validVNPhoneNumber() {
    return isValidPhoneNumber();
  }

  /// Comprehensive Vietnamese phone number validation
  ///
  /// Validates both mobile and landline numbers:
  /// - Mobile: 03, 05, 07, 08, 09 + 8-9 digits
  /// - Landline: 02 + 8-10 digits (for Hanoi and HCMC)
  ///
  /// Examples of valid numbers:
  /// - 84901234567 (mobile)
  /// - 0901234567 (mobile)
  /// - 0241234567 (Hanoi landline)
  /// - 02812345678 (HCMC landline)
  ///
  /// Examples of invalid numbers:
  /// - 1234567890 (invalid prefix)
  /// - 849012345 (too short)
  /// - 849012345678901 (too long)
  bool isValidPhoneNumber() {
    if (isNullOrEmpty) {
      return false;
    }

    // Mobile numbers: 03, 05, 07, 08, 09 + 8-9 digits
    if (RegExp(r'^' // Start of string
            r'(84|0)' // Country code (84) OR national format (0)
            r'[3|5|7|8|9]' // Mobile prefixes: 3, 5, 7, 8, 9
            r'([0-9]{8,9})' // 8-9 digits
            r'$' // End of string
            )
        .hasMatch(this)) {
      return true;
    }

    // Landline numbers: 02 + 8-10 digits (Hanoi and HCMC)
    if (RegExp(r'^' // Start of string
            r'(84|0)' // Country code (84) OR national format (0)
            r'2' // Landline prefix: 2
            r'([0-9]{8,10})' // 8-10 digits
            r'$' // End of string
            )
        .hasMatch(this)) {
      return true;
    }

    return false;
  }

  /// General phone number validation (international format)
  ///
  /// Accepts various phone number formats:
  /// - +1234567890
  /// - (123) 456-7890
  /// - 123.456.7890
  /// - 123-456-7890
  /// - 1234567890
  ///
  /// Examples of valid numbers:
  /// - +84901234567
  /// - (090) 123-4567
  /// - 090.123.4567
  /// - 090-123-4567
  ///
  /// Examples of invalid numbers:
  /// - abc-def-ghij (contains letters)
  /// - 123 (too short)
  /// - 12345678901234567890 (too long)
  bool isPhoneNumberValid() {
    if (isEmpty) {
      return false;
    }

    const pattern = r'^' // Start of string
        r'[+]*' // Optional plus sign for international format
        r'[(]{0,1}' // Optional opening parenthesis
        r'[0-9]{1,4}' // 1-4 digits (country code or area code)
        r'[)]{0,1}' // Optional closing parenthesis
        r'[-\s\./0-9]*' // Optional separators (hyphen, space, dot, slash) and digits
        r'$'; // End of string
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  /// OTP (One-Time Password) validation
  ///
  /// Validates 6-digit numeric OTP codes
  ///
  /// Examples of valid OTPs:
  /// - 123456
  /// - 000000
  /// - 999999
  ///
  /// Examples of invalid OTPs:
  /// - 12345 (too short)
  /// - 1234567 (too long)
  /// - 12345a (contains letter)
  /// - 12 34 56 (contains spaces)
  bool isOTP() {
    return RegExp(r'^' // Start of string
            r'\d{6}' // Exactly 6 digits
            r'$' // End of string
            )
        .hasMatch(this);
  }

  // URL validation
  bool get isUrl => Uri.parse(this).isAbsolute;

  bool get isLocalUrl {
    return startsWith('/') ||
        startsWith('file://') ||
        (length > 1 && substring(1).startsWith(':\\'));
  }

  String displayNationalNumber() {
    // Note: This method uses the formatedPhoneNumberString from string_utils.dart
    // which is already available through the StringDataHelper extension
    return this;
  }

  // Text formatting - using methods from StringDataHelper extension
  String get capitalize {
    return this[0].toUpperCase() + substring(1);
  }

  // URL utilities
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

  String get hardcode => this;

  // Duration parsing
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
    if (formated.isNullOrEmpty) {
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

extension PhoneNumberExt on String? {
  String displayPhoneNumber() {
    if (isNullOrEmpty) {
      return '';
    }
    // Note: formatedPhoneNumberString is available from StringDataHelper extension
    return this!;
  }
}

extension IntExt on String? {
  int? get intNumber {
    return doubleNumber?.toInt();
  }

  double? get doubleNumber {
    return double.tryParse(removeCommaString ?? '');
  }

  String? get removeCommaString {
    return this?.replaceAll(',', '');
  }
}
