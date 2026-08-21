import 'package:design_system_project/components/ds_input/formatters/decimal_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DecimalTextInputFormatter formatter({
    int? maxDecimalDigits = 2,
    double? min,
    double? max,
  }) {
    return DecimalTextInputFormatter(
      maxDecimalDigits: maxDecimalDigits,
      min: min,
      max: max,
    );
  }

  TextEditingValue apply(
    DecimalTextInputFormatter inputFormatter, {
    required String oldText,
    required String newText,
    int? oldOffset,
    int? newOffset,
  }) {
    return inputFormatter.formatEditUpdate(
      TextEditingValue(
        text: oldText,
        selection: TextSelection.collapsed(offset: oldOffset ?? oldText.length),
      ),
      TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newOffset ?? newText.length),
      ),
    );
  }

  group('DecimalTextInputFormatter', () {
    test('keeps integer digits without adding decimal zeros', () {
      final result = apply(
        formatter(),
        oldText: '1',
        newText: '12',
      );
      expect(result.text, '12');
      expect(result.selection.baseOffset, 2);
      expect(result.composing, TextRange.empty);
    });

    test('inserts thousand separators without moving caret off the last digit',
        () {
      final result = apply(
        formatter(),
        oldText: '123',
        newText: '1234',
      );
      expect(result.text, '1.234');
      expect(result.selection.baseOffset, 5);
    });

    test('treats typed period as decimal comma', () {
      final result = apply(
        formatter(),
        oldText: '1',
        newText: '1.',
      );
      expect(result.text, '1,');
      expect(result.selection.baseOffset, 2);
    });

    test('allows typing after comma without appending a trailing zero', () {
      final result = apply(
        formatter(),
        oldText: '1,',
        newText: '1,5',
      );
      expect(result.text, '1,5');
      expect(result.selection.baseOffset, 3);
    });

    test('keeps trailing fraction zeros while typing', () {
      final result = apply(
        formatter(),
        oldText: '1,5',
        newText: '1,50',
      );
      expect(result.text, '1,50');
    });

    test('rejects extra fraction digits beyond maxDecimalDigits', () {
      final result = apply(
        formatter(maxDecimalDigits: 2),
        oldText: '1,50',
        newText: '1,501',
      );
      expect(result.text, '1,50');
    });

    test('rejects values above max instead of rewriting the field', () {
      final result = apply(
        formatter(min: 0, max: 100),
        oldText: '10',
        newText: '101',
      );
      expect(result.text, '10');
    });

    test('treats pasted 1.5 as decimal 1,5', () {
      final result = formatter().formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(
          text: '1.5',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );
      expect(result.text, '1,5');
    });

    test('deleting the comma concatenates integer and fraction', () {
      final result = apply(
        formatter(),
        oldText: '12,5',
        newText: '125',
        oldOffset: 2,
        newOffset: 2,
      );
      expect(result.text, '125');
    });
  });
}
