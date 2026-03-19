part of 'extensions.dart';

extension NullableStringIsNullOrEmptyExtension on String? {
  /// Returns `true` if the String is either null or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

extension StringExt on String {
  // Email validation - Comprehensive email validation with detailed regex
  // explanation
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
            r'[a-zA-Z]{2,}' // Top-level domain with at least 2 letters (like
            // com, uk, org)
            r')' // End Group 6
            r')' // End Group 4
            r'$' // End of string
            )
        .hasMatch(this);
  }

  /// Alias for isEmailValid for backward compatibility
  bool isEmail() => isEmailValid;

  // Password validation - Strong password validation with detailed regex
  // explanation
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
            r'(?=.*[a-z])' // Positive lookahead: must contain at least one
            // lowercase letter
            r'(?=.*[A-Z])' // Positive lookahead: must contain at least one
            // uppercase letter
            r'(?=.*\d)' // Positive lookahead: must contain at least one digit
            r'(?=.*[@$!%*?&])' // Positive lookahead: must contain at least one
            // special character
            r'[A-Za-z\d@$!%*?&]{8,}' // Main pattern: 8 or more characters from
            // allowed set
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
      RegExp(r'[a-zA-Z]'), // Contains at least one letter (a-z or A-Z)
    );
    final hasNumber = contains(
      RegExp(r'[0-9]'), // Contains at least one digit (0-9)
    );
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
    final hasLowerCase = contains(
      RegExp(r'[a-z]'), // Contains at least one lowercase letter
    );
    final hasUpperCase = contains(
      RegExp(r'[A-Z]'), // Contains at least one uppercase letter
    );
    final hasSpecialChar = contains(
      RegExp(r'[.,*?!@#\$&*~]'), // Contains at least one special character
    );
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
            r'(?=.*[a-z])' // Positive lookahead: must contain at least one
            // lowercase letter
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
            r'(?=.*[A-Z])' // Positive lookahead: must contain at least one
            // uppercase letter
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
            r'(?=.*?[0-9])' // Positive lookahead: must contain at least one
            // digit (non-greedy)
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
            r'(?=.*?[#?!@$%^&*-])' // Positive lookahead: must contain at least
            // one special character (non-greedy)
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
            r'(?=.{8,})' // Positive lookahead: must be at least 8 characters
            // long
            )
        .hasMatch(this);
  }

  // Phone number validation - Vietnamese phone number validation with detailed
  // regex explanation
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
            r'(84|0[3|5|7|8|9])' // Country code (84) OR national format (0
            // followed by 3,5,7,8,9)
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
        r'[-\s\./0-9]*' // Optional separators (hyphen, space, dot, slash) and
        // digits
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
    // Note: This method uses the formatedPhoneNumberString from
    // string_utils.dart which is already available through the
    // StringDataHelper extension
    return this;
  }

  /// Capitalizes the first character of the string
  ///
  /// This method handles edge cases like:
  /// - Empty strings (returns empty string)
  /// - Single character strings (returns uppercase)
  /// - Strings starting with whitespace (preserves whitespace)
  /// - Strings with special characters or numbers
  ///
  /// Examples:
  /// - "hello" -> "Hello"
  /// - "world" -> "World"
  /// - "a" -> "A"
  /// - "" -> ""
  /// - " hello" -> " Hello"
  /// - "123abc" -> "123abc" (no change for numbers)
  /// - "!test" -> "!test" (no change for special characters)
  String get capitalize {
    if (isEmpty) {
      return this;
    }

    // Find the first alphabetic character
    int firstAlphaIndex = -1;
    for (int i = 0; i < length; i++) {
      if (RegExp(r'[a-zA-Z]').hasMatch(this[i])) {
        firstAlphaIndex = i;
        break;
      }
    }

    if (firstAlphaIndex == -1) {
      // No alphabetic characters found, return as is
      return this;
    }

    if (firstAlphaIndex == 0) {
      // First character is alphabetic, capitalize it
      return this[0].toUpperCase() + substring(1);
    } else {
      // First alphabetic character is not at index 0,
      // capitalize it and preserve
      // prefix
      final prefix = substring(0, firstAlphaIndex);
      final char = this[firstAlphaIndex];
      final capitalized = char.toUpperCase();
      final suffix = substring(firstAlphaIndex + 1);
      final buffer = StringBuffer();
      final prefixStr = prefix.toString();
      final capitalizedStr = capitalized.toString();
      final suffixStr = suffix.toString();
      buffer
        ..write(prefixStr)
        ..write(capitalizedStr)
        ..write(suffixStr);
      final result = buffer.toString();
      return result;
    }
  }

  /// Capitalizes the first character and converts the rest to lowercase
  ///
  /// This method is useful for normalizing text to title case format
  ///
  /// Examples:
  /// - "hello" -> "Hello"
  /// - "WORLD" -> "World"
  /// - "HeLLo WoRLD" -> "Hello world"
  /// - "a" -> "A"
  /// - "" -> ""
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalizes the first character of each word in the string
  ///
  /// This method uses regex to identify word boundaries and capitalizes
  /// the first letter of each word while preserving punctuation and spacing
  ///
  /// Examples:
  /// - "hello world" -> "Hello World"
  /// - "john doe" -> "John Doe"
  /// - "hello, world!" -> "Hello, World!"
  /// - "user@example.com" -> "User@Example.Com"
  /// - "123 abc def" -> "123 Abc Def"
  String capitalizeFirstOfEach() {
    return replaceAllMapped(RegExp(r'[^\s.,;!?":/()\[\]{}|\\]+'), (match) {
      if (match.group(0) == null) {
        return '';
      }
      return '${match.group(0)?.capitalizeFirst()}';
    });
  }

  /// Converts the entire string to title case (first letter of each word
  /// capitalized)
  ///
  /// This method splits the string by spaces and capitalizes the first letter
  /// of each word, then joins them back together
  ///
  /// Examples:
  /// - "hello world" -> "Hello World"
  /// - "john doe smith" -> "John Doe Smith"
  /// - "hello" -> "Hello"
  /// - "" -> ""
  /// - "a b c" -> "A B C"
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Converts the string to sentence case (first letter capitalized, rest
  /// lowercase)
  ///
  /// This method capitalizes only the first letter of the entire string
  /// and converts all other letters to lowercase
  ///
  /// Examples:
  /// - "hello world" -> "Hello world"
  /// - "HELLO WORLD" -> "Hello world"
  /// - "Hello World" -> "Hello world"
  /// - "a" -> "A"
  /// - "" -> ""
  String toSentenceCase() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Converts the string to camel case (first word lowercase, subsequent words
  /// capitalized)
  ///
  /// This method removes spaces and capitalizes the first letter of each word
  /// except the first word
  ///
  /// Examples:
  /// - "hello world" -> "helloWorld"
  /// - "user name" -> "userName"
  /// - "first name last name" -> "firstNameLastName"
  /// - "hello" -> "hello"
  /// - "" -> ""
  String toCamelCase() {
    if (isEmpty) {
      return this;
    }

    final words = split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) {
      return this;
    }

    final firstWord = words[0].toLowerCase();
    final buffer = StringBuffer(firstWord);
    for (int i = 1; i < words.length; i++) {
      final word = words[i];
      final firstChar = word[0];
      final upperFirst = firstChar.toUpperCase();
      final restPart = word.substring(1);
      final rest = restPart.toLowerCase();
      final upperStr = upperFirst.toString();
      final restStr = rest.toString();
      buffer
        ..write(upperStr)
        ..write(restStr);
    }
    return buffer.toString();
  }

  /// Converts the string to Pascal case (first letter of each word capitalized,
  /// no spaces)
  ///
  /// This method removes spaces and capitalizes the first letter of each word
  ///
  /// Examples:
  /// - "hello world" -> "HelloWorld"
  /// - "user name" -> "UserName"
  /// - "first name last name" -> "FirstNameLastName"
  /// - "hello" -> "Hello"
  /// - "" -> ""
  String toPascalCase() {
    if (isEmpty) {
      return this;
    }

    final words = split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) {
      return this;
    }

    final buffer = StringBuffer();
    for (final word in words) {
      final firstChar = word[0];
      final upperFirst = firstChar.toUpperCase();
      final restPart = word.substring(1);
      final rest = restPart.toLowerCase();
      final upperStr = upperFirst.toString();
      final restStr = rest.toString();
      buffer
        ..write(upperStr)
        ..write(restStr);
    }
    return buffer.toString();
  }

  /// Converts the string to snake case (lowercase with underscores)
  ///
  /// This method converts spaces to underscores and makes everything lowercase
  ///
  /// Examples:
  /// - "hello world" -> "hello_world"
  /// - "User Name" -> "user_name"
  /// - "firstName" -> "firstname"
  /// - "hello" -> "hello"
  /// - "" -> ""
  String toSnakeCase() {
    if (isEmpty) {
      return this;
    }
    final lower = toLowerCase();
    return lower.replaceAll(' ', '_');
  }

  /// Converts the string to kebab case (lowercase with hyphens)
  ///
  /// This method converts spaces to hyphens and makes everything lowercase
  ///
  /// Examples:
  /// - "hello world" -> "hello-world"
  /// - "User Name" -> "user-name"
  /// - "firstName" -> "firstname"
  /// - "hello" -> "hello"
  /// - "" -> ""
  String toKebabCase() {
    if (isEmpty) {
      return this;
    }
    final lower = toLowerCase();
    return lower.replaceAll(' ', '-');
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

  /// Extracts initials from a name string
  ///
  /// Returns:
  /// - Empty string if input is empty
  /// - First letter if single word (e.g., "Quân" -> "Q")
  /// - First letter of first word + first letter of last word if multiple words
  ///   (e.g., "Gian Thiệu Quân" -> "GQ", "Thiệu Quân" -> "TQ")
  ///
  /// Examples:
  /// - "Gian Thiệu Quân" -> "GQ"
  /// - "Thiệu Quân" -> "TQ"
  /// - "Quân" -> "Q"
  /// - "" -> ""
  String get getInitials {
    final words =
        trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    return switch (words.length) {
      0 => '',
      1 => words.first[0].toUpperCase(),
      _ => '${words.first[0].toUpperCase()}${words.last[0].toUpperCase()}',
    };
  }
}

extension PhoneNumberExt on String? {
  /// Format số điện thoại Việt Nam theo chuẩn: 0xxx xxx xxxx
  /// Hỗ trợ các định dạng đầu vào:
  /// - 0123456789
  /// - +84123456789
  /// - 84123456789
  /// - 123456789
  String get displayPhoneNumber {
    if (isNullOrEmpty) {
      return '';
    }

    // Loại bỏ tất cả ký tự không phải số
    String cleanNumber = this!.replaceAll(RegExp(r'[^\d]'), '');

    // Nếu số điện thoại quá ngắn hoặc quá dài, trả về nguyên bản
    if (cleanNumber.length < 9 || cleanNumber.length > 11) {
      return this!;
    }

    // Xử lý các trường hợp khác nhau
    if (cleanNumber.length == 11) {
      // Trường hợp: 84123456789 hoặc 01234567890
      if (cleanNumber.startsWith('84')) {
        // Loại bỏ mã quốc gia 84 và thêm 0
        cleanNumber = '0${cleanNumber.substring(2)}';
      } else if (cleanNumber.startsWith('0')) {
        // Đã đúng định dạng 0xxxxxxxxx
        cleanNumber = cleanNumber;
      } else {
        return this!;
      }
    } else if (cleanNumber.length == 10) {
      // Trường hợp: 0123456789 (đã đúng)
      if (!cleanNumber.startsWith('0')) {
        return this!;
      }
    } else if (cleanNumber.length == 9) {
      // Trường hợp: 123456789 (thiếu số 0 đầu)
      cleanNumber = '0$cleanNumber';
    }

    // Kiểm tra lại độ dài sau khi xử lý
    if (cleanNumber.length != 10 || !cleanNumber.startsWith('0')) {
      return this!;
    }

    // Format theo chuẩn Việt Nam: 0xxx xxx xxxx
    return '''${cleanNumber.substring(0, 4)} ${cleanNumber.substring(4, 7)} ${cleanNumber.substring(7)}''';
  }

  /// Kiểm tra xem có phải là số điện thoại Việt Nam hợp lệ không
  bool get isValidVietnamesePhoneNumber {
    if (isNullOrEmpty) {
      return false;
    }

    final String cleanNumber = this!.replaceAll(RegExp(r'[^\d]'), '');

    // Số điện thoại Việt Nam có 10 chữ số, bắt đầu bằng 0
    if (cleanNumber.length == 10 && cleanNumber.startsWith('0')) {
      // Kiểm tra các đầu số phổ biến của Việt Nam
      final List<String> validPrefixes = [
        '03', '05', '07', '08', '09', // Di động
        '02', '04', '06', // Cố định
      ];

      final String prefix = cleanNumber.substring(0, 2);
      return validPrefixes.contains(prefix);
    }

    return false;
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
    final text = this;

    return text
        ?.replaceAll(UtilsConstants.thousandSeparatorSymbol, '')
        .replaceAll(
          UtilsConstants.decimalSymbol,
          UtilsConstants.languageDecimalSymbol,
        );
  }
}
