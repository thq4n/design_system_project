part of '../../ds_colors_core.dart';

class _DSGrayColor extends DSColor {
  const _DSGrayColor([super.value = 0xFF737373]);

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
  DSColor get shade500 => const _DSGrayColor(0xFF737373); // Primary Gray
  @override
  DSColor get tint400 => const _DSGrayColor(0xFFA3A3A3);
  @override
  DSColor get tint300 => const _DSGrayColor(0xFFD4D4D4);
  @override
  DSColor get tint200 => const _DSGrayColor(0xFFE5E5E5);
  @override
  DSColor get tint100 => const _DSGrayColor(0xFFF1F4F5);
  @override
  DSColor get tint50 => const _DSGrayColor(0xFFF9FAFB);
  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSGrayColor(withValues(alpha: opacity).toARGB32());
  }
}
