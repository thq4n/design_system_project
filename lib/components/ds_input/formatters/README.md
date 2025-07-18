# DSInput Formatters

This directory contains text input formatters for the DSInput component.

## Available Formatters

### DecimalTextInputFormatter
Allows only decimal numbers (digits and at most one decimal point).

**Usage:**
```dart
import 'package:design_system_project/components/ds_input/formatters/formatters.dart';

DSInput(
  inputFormatters: [DecimalTextInputFormatter()],
  // ... other properties
)
```

**Features:**
- Allows digits (0-9)
- Allows one decimal point (.)
- Prevents multiple decimal points
- Prevents non-numeric characters

### IntegerTextInputFormatter
Allows only integer numbers (digits only, no decimal points).

**Usage:**
```dart
import 'package:design_system_project/components/ds_input/formatters/formatters.dart';

DSInput(
  inputFormatters: [IntegerTextInputFormatter()],
  // ... other properties
)
```

**Features:**
- Allows digits (0-9)
- Prevents decimal points
- Prevents non-numeric characters

## Importing

To use all formatters, import the main formatters file:

```dart
import 'package:design_system_project/components/ds_input/formatters/formatters.dart';
```

To import individual formatters:

```dart
import 'package:design_system_project/components/ds_input/formatters/decimal_text_input_formatter.dart';
import 'package:design_system_project/components/ds_input/formatters/integer_text_input_formatter.dart';
```

## Testing

Run the formatter tests:

```bash
flutter test lib/components/ds_input/formatters/formatters_test.dart
```

## Adding New Formatters

To add a new formatter:

1. Create a new file in this directory (e.g., `email_text_input_formatter.dart`)
2. Extend `TextInputFormatter` and implement the `formatEditUpdate` method
3. Add proper documentation
4. Export the formatter in `formatters.dart`
5. Add tests in `formatters_test.dart` 