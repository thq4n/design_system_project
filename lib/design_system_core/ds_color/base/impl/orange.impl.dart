part of '../../ds_colors_core.dart';

class _DSOrangeColor extends DSColor {
  const _DSOrangeColor([super.value = 0xFFF44405]);

  @override
  DSColor get black => const _DSBlueColor(0xFF000000);
  @override
  DSColor get white => const _DSBlueColor(0xFFFFFFFF);
  @override
  @override
  DSColor get shade950 => const _DSOrangeColor(0xFF57130A);
  @override
  DSColor get shade900 => const _DSOrangeColor(0xFF771A0D);
  @override
  DSColor get shade800 => const _DSOrangeColor(0xFF97180C);
  @override
  DSColor get shade700 => const _DSOrangeColor(0xFFBC1B06);
  @override
  DSColor get shade600 => const _DSOrangeColor(0xFFE62E05);
  @override
  DSColor get shade500 => const _DSOrangeColor(0xFFF44405); // Primary Orange
  @override
  DSColor get tint400 => const _DSOrangeColor(0xFFF6926E);
  @override
  DSColor get tint300 => const _DSOrangeColor(0xFFF9C6B6);
  @override
  DSColor get tint200 => const _DSOrangeColor(0xFFFED6AE);
  @override
  DSColor get tint100 => const _DSOrangeColor(0xFFFEE6D5);
  @override
  DSColor get tint50 => const _DSOrangeColor(0xFFFFF4ED);

  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSOrangeColor(withValues(alpha: opacity).toARGB32());
  }
}
