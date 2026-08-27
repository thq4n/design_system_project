part of '../../ds_colors_core.dart';

class _DSYellowColor extends DSColor {
  const _DSYellowColor([super.value = 0xFFF79009]);

  @override
  DSColor get black => const _DSBlueColor(0xFF000000);
  @override
  DSColor get white => const _DSBlueColor(0xFFFFFFFF);
  @override
  DSColor get shade950 => const _DSYellowColor(0xFF4E1D09);
  @override
  DSColor get shade900 => const _DSYellowColor(0xFF7A2E0E);
  @override
  DSColor get shade800 => const _DSYellowColor(0xFF93370D);
  @override
  DSColor get shade700 => const _DSYellowColor(0xFFB54708);
  @override
  DSColor get shade600 => const _DSYellowColor(0xFFDC6803);
  @override
  DSColor get shade500 => const _DSYellowColor(0xFFF79009); // Primary Yellow
  @override
  DSColor get shade400 => const _DSYellowColor(0xFFFDB022);
  @override
  DSColor get shade300 => const _DSYellowColor(0xFFFEC84B);
  @override
  DSColor get shade200 => const _DSYellowColor(0xFFFEDF89);
  @override
  DSColor get shade100 => const _DSYellowColor(0xFFFEF0C7);
  @override
  DSColor get shade50 => const _DSYellowColor(0xFFFFFAEB);

  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSYellowColor(withValues(alpha: opacity).toARGB32());
  }
}
