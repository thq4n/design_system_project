part of '../../ds_colors_core.dart';

class _DSBlackColor extends DSColor {
  const _DSBlackColor([super.value = 0xFF000000]);

  // Black color shades from darkest to lightest
  @override
  DSColor get shade950 => const _DSBlackColor(0xFF000000); // Pure black
  @override
  DSColor get shade900 => const _DSBlackColor(0xFF141414);
  @override
  DSColor get shade800 => const _DSBlackColor(0xFF292929);
  @override
  DSColor get shade700 => const _DSBlackColor(0xFF3D3D3D);
  @override
  DSColor get shade600 => const _DSBlackColor(0xFF525252);
  @override
  DSColor get shade500 => const _DSBlackColor(0xFF666666);

  // Black color tints (getting lighter)
  @override
  DSColor get tint400 => const _DSBlackColor(0xFF808080);
  @override
  DSColor get tint300 => const _DSBlackColor(0xFF999999);
  @override
  DSColor get tint200 => const _DSBlackColor(0xFFB3B3B3);
  @override
  DSColor get tint100 => const _DSBlackColor(0xFFCCCCCC);
  @override
  DSColor get tint50 => const _DSBlackColor(0xFFE6E6E6);

  // You might want to add a more semantic name for the primary shade
  @override
  DSColor get primary => shade950;

  @override
  DSColor withOpacity(double opacity) {
    return _DSBlackColor(withValues(alpha: opacity).toARGB32());
  }
}
