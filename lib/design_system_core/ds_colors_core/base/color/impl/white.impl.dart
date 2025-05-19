part of '../../../ds_colors_core.dart';

class _DSWhiteColor extends DSColor {
  const _DSWhiteColor([super.value = 0xFFFFFFFF]);

  // White color shades from darkest to lightest
  @override
  DSColor get shade950 => _DSWhiteColor(0xFFE6E6E6);
  @override
  DSColor get shade900 => _DSWhiteColor(0xFFEBEBEB);
  @override
  DSColor get shade800 => _DSWhiteColor(0xFFF0F0F0);
  @override
  DSColor get shade700 => _DSWhiteColor(0xFFF5F5F5);
  @override
  DSColor get shade600 => _DSWhiteColor(0xFFFAFAFA);
  @override
  DSColor get shade500 => _DSWhiteColor(0xFFFFFFFF); // Pure white

  // White color tints (getting darker)
  @override
  DSColor get tint400 => _DSWhiteColor(0xFFCCCCCC);
  @override
  DSColor get tint300 => _DSWhiteColor(0xFFB3B3B3);
  @override
  DSColor get tint200 => _DSWhiteColor(0xFF999999);
  @override
  DSColor get tint100 => _DSWhiteColor(0xFF808080);
  @override
  DSColor get tint50 => _DSWhiteColor(0xFF666666);

  // Primary shade is pure white
  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSWhiteColor(withValues(alpha: opacity).toARGB32());
  }
}
