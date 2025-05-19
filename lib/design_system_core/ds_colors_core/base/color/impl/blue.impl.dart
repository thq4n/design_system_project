part of '../../../ds_colors_core.dart';

class _DSBlueColor extends DSColor {
  const _DSBlueColor([super.value = 0xFF2970FF]);

  @override
  DSColor get shade950 => _DSBlueColor(0xFF002266);
  @override
  DSColor get shade900 => _DSBlueColor(0xFF00359E);
  @override
  DSColor get shade800 => _DSBlueColor(0xFF0040C1);
  @override
  DSColor get shade700 => _DSBlueColor(0xFF004EEB);
  @override
  DSColor get shade600 => _DSBlueColor(0xFF155EEF);
  @override
  DSColor get shade500 => _DSBlueColor(0xFF2970FF); // Primary Blue
  @override
  DSColor get tint400 => _DSBlueColor(0xFF528BFF);
  @override
  DSColor get tint300 => _DSBlueColor(0xFF84ADFF);
  @override
  DSColor get tint200 => _DSBlueColor(0xFFB2CCFF);
  @override
  DSColor get tint100 => _DSBlueColor(0xFFD1E0FF);
  @override
  DSColor get tint50 => _DSBlueColor(0xFFEFF4FF);

  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSBlueColor(withValues(alpha: opacity).toARGB32());
  }
}
