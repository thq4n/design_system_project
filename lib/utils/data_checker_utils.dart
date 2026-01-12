import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../extensions/extensions.dart';

/// Safely converts a dynamic value to type T, returning null if conversion
/// fails.
///
/// **Supported Types:**
/// - `String`, `int`, `double`, `bool` (primitive types)
/// - `DateTime` (from ISO 8601 string)
/// - `Duration` (from string using parseDuration extension)
/// - `Color` (from hex string)
/// - `List<String>`, `List<int>`, `List<double>` (specific list types)
///
/// **Important Notes:**
/// - For unsupported types, this function will return `null` (or
///   `defaultValue` if provided)
/// - Always use `fromJson: asOrNull` in `@JsonKey` for nullable fields
/// - For complex types (custom classes, generic lists), use custom converters
///   instead
/// - This function is type-safe and handles null values gracefully
///
/// **Usage in JsonSerializable:**
/// ```dart
/// @JsonKey(name: 'fieldName', fromJson: asOrNull)
/// final String? fieldName;
/// ```
T? asOrNull<T>(dynamic value, [T? defaultValue]) {
  // Direct type match - fastest path
  if (value is T) {
    return value;
  }

  // Handle null values
  if (value == null) {
    return defaultValue;
  }

  try {
    final tType = T.toString();

    // Handle bool type
    if (tType == 'bool' || tType == 'bool?') {
      if (value is bool) {
        return value as T;
      }
      // Try to convert from common representations
      if (value is int) {
        return (value != 0) as T;
      }
      if (value is String) {
        final lower = value.toLowerCase();
        if (lower == 'true' || lower == '1' || lower == 'yes') {
          return true as T;
        }
        if (lower == 'false' || lower == '0' || lower == 'no') {
          return false as T;
        }
      }
      return defaultValue;
    }

    // Handle String type
    if (tType == 'String' || tType == 'String?') {
      if (value is String) {
        return value as T;
      }
      // Convert other types to string
      return value.toString() as T;
    }

    // Handle List types
    if (tType == 'List<String>' || tType == 'List<String>?') {
      if (value is List) {
        return value.cast<String>() as T;
      }
      return defaultValue;
    }
    if (tType == 'List<double>' || tType == 'List<double>?') {
      if (value is List) {
        return value.cast<double>() as T;
      }
      return defaultValue;
    }
    if (tType == 'List<int>' || tType == 'List<int>?') {
      if (value is List) {
        return value.cast<int>() as T;
      }
      return defaultValue;
    }

    // Handle DateTime type
    if (tType == 'DateTime' || tType == 'DateTime?') {
      if (value is DateTime) {
        return value as T;
      }
      if (value is String) {
        return DateTime.parse(value).toLocal() as T;
      }
      if (value is int) {
        // Handle Unix timestamp (milliseconds)
        return DateTime.fromMillisecondsSinceEpoch(value).toLocal() as T;
      }
      return defaultValue;
    }

    // Handle numeric types
    if (value is num) {
      if (tType == 'double' || tType == 'double?') {
        return value.toDouble() as T;
      }
      if (tType == 'int' || tType == 'int?') {
        return value.toInt() as T;
      }
    }

    // Handle Duration type
    if (tType == 'Duration' || tType == 'Duration?') {
      if (value is Duration) {
        return value as T;
      }
      if (value is String) {
        return value.parseDuration() as T;
      }
      if (value is int) {
        // Handle duration in milliseconds
        return Duration(milliseconds: value) as T;
      }
      return defaultValue;
    }

    // Handle Color type
    if (tType == 'Color' || tType == 'Color?') {
      if (value is Color) {
        return value as T;
      }
      if (value is String) {
        var hexColor = value.replaceAll('#', '');
        if (hexColor.length == 6) {
          hexColor = 'FF$hexColor';
        }
        if (hexColor.length == 8) {
          return Color(int.parse('0x$hexColor')) as T;
        }
      }
      return defaultValue;
    }

    // Type not supported - return null or defaultValue
    if (kDebugMode) {
      debugPrint(
        'asOrNull: Type $tType is not supported. '
        'Value: $value (${value.runtimeType})',
      );
    }
    return defaultValue;
  } catch (e, stackTrace) {
    debugPrint('asOrNull error: $e\nStack trace: $stackTrace');
    if (kDebugMode) {
      rethrow;
    }
    return defaultValue;
  }
}

String? parseDuration(Duration? duration) {
  return duration?.hhmmss;
}
