part of '../../ds_colors_core.dart';

class _DSBlueColor extends DSColor {
  const _DSBlueColor([super.value = 0xFF2970FF]);

  @override
  DSColor get black => const _DSBlueColor(0xFF000000);
  @override
  DSColor get white => const _DSBlueColor(0xFFFFFFFF);
  @override
  DSColor get shade950 => const _DSBlueColor(0xFF002266);
  @override
  DSColor get shade900 => const _DSBlueColor(0xFF00359E);
  @override
  DSColor get shade800 => const _DSBlueColor(0xFF0040C1);
  @override
  DSColor get shade700 => const _DSBlueColor(0xFF004EEB);
  @override
  DSColor get shade600 => const _DSBlueColor(0xFF155EEF);
  @override
  DSColor get shade500 => const _DSBlueColor(0xFF2970FF); // Primary Blue
  @override
  DSColor get shade400 => const _DSBlueColor(0xFF528BFF);
  @override
  DSColor get shade300 => const _DSBlueColor(0xFF84ADFF);
  @override
  DSColor get shade200 => const _DSBlueColor(0xFFB2CCFF);
  @override
  DSColor get shade100 => const _DSBlueColor(0xFFD1E0FF);
  @override
  DSColor get shade50 => const _DSBlueColor(0xFFEFF4FF);

  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSBlueColor(withValues(alpha: opacity).toARGB32());
  }
}
