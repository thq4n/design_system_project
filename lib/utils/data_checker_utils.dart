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
    // Prefer "convert then type-check" to avoid relying on type names.
    // This remains stable under --obfuscate because it uses runtime checks,
    // not T.toString() comparisons.

    // Numbers → int/double
    if (value is num) {
      final asInt = value.toInt();
      if (asInt is T) {
        return asInt as T;
      }

      final asDouble = value.toDouble();
      if (asDouble is T) {
        return asDouble as T;
      }
    }

    // String → bool/int/double/DateTime/Duration/Color (only return if cast matches T)
    if (value is String) {
      final lower = value.toLowerCase();
      if (lower == 'true' || lower == '1' || lower == 'yes') {
        const asBool = true;
        if (asBool is T) {
          return asBool as T;
        }
      }
      if (lower == 'false' || lower == '0' || lower == 'no') {
        const asBool = false;
        if (asBool is T) {
          return asBool as T;
        }
      }

      final asInt = int.tryParse(value);
      if (asInt != null && asInt is T) {
        return asInt as T;
      }

      final asDouble = double.tryParse(value);
      if (asDouble != null && asDouble is T) {
        return asDouble as T;
      }

      final asDateTime = DateTime.tryParse(value)?.toLocal();
      if (asDateTime != null && asDateTime is T) {
        return asDateTime as T;
      }

      try {
        final asDuration = value.parseDuration();
        if (asDuration is T) {
          return asDuration as T;
        }
      } catch (_) {
        // ignore
      }

      try {
        var hexColor = value.replaceAll('#', '');
        if (hexColor.length == 6) {
          hexColor = 'FF$hexColor';
        }
        if (hexColor.length == 8) {
          final asColor = Color(int.parse('0x$hexColor'));
          if (asColor is T) {
            return asColor as T;
          }
        }
      } catch (_) {
        // ignore
      }
    }

    // int milliseconds → DateTime/Duration
    if (value is int) {
      final asDateTime = DateTime.fromMillisecondsSinceEpoch(value).toLocal();
      if (asDateTime is T) {
        return asDateTime as T;
      }

      final asDuration = Duration(milliseconds: value);
      if (asDuration is T) {
        return asDuration as T;
      }
    }

    // Lists → specific supported list types
    if (value is List) {
      try {
        final asStringList = value.cast<String>();
        if (asStringList is T) {
          return asStringList as T;
        }
      } catch (_) {
        // ignore
      }
      try {
        final asIntList = value.cast<int>();
        if (asIntList is T) {
          return asIntList as T;
        }
      } catch (_) {
        // ignore
      }
      try {
        final asDoubleList = value.cast<double>();
        if (asDoubleList is T) {
          return asDoubleList as T;
        }
      } catch (_) {
        // ignore
      }
    }

    // Fallback: stringify if that matches T (e.g. T == String)
    final asString = value.toString();
    if (asString is T) {
      return asString as T;
    }

    // Type not supported - return null or defaultValue
    if (kDebugMode) {
      debugPrint(
        'asOrNull: Type $T is not supported. '
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
