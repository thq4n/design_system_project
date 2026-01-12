part of '../../ds_colors_core.dart';

class _DSGrayColor extends DSColor {
  const _DSGrayColor([super.value = 0xFF737373]);

  @override
  DSColor get black => const _DSBlueColor(0xFF000000);
  @override
  DSColor get white => const _DSBlueColor(0xFFFFFFFF);
  @override
  @override
  DSColor get shade950 => const _DSGrayColor(0xFF0a0a0a);
  @override
  DSColor get shade900 => const _DSGrayColor(0xFF171717);
  @override
  DSColor get shade800 => const _DSGrayColor(0xFF262626);
  @override
  DSColor get shade700 => const _DSGrayColor(0xFF404040);
  @override
  DSColor get shade600 => const _DSGrayColor(0xFF525252);
  @override
  DSColor get shape500 => const _DSGrayColor(0xFF737373); // Primary Gray
  @override
  DSColor get shape400 => const _DSGrayColor(0xFFA3A3A3);
  @override
  DSColor get shape300 => const _DSGrayColor(0xFFD4D4D4);
  @override
  DSColor get shape200 => const _DSGrayColor(0xFFE5E5E5);
  @override
  DSColor get shape100 => const _DSGrayColor(0xFFF1F4F5);
  @override
  DSColor get shape50 => const _DSGrayColor(0xFFF9FAFB);
  @override
  DSColor get primary => shape500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSGrayColor(withValues(alpha: opacity).toARGB32());
  }
}
