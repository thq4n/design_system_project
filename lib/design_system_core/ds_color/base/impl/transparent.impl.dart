part of '../../ds_colors_core.dart';

class _DSTransparentColor extends DSColor {
  const _DSTransparentColor([super.value = 0x00000000]);

  @override
  DSColor get black => const _DSBlueColor(0xFF000000);
  @override
  DSColor get white => const _DSBlueColor(0xFFFFFFFF);
  @override
  // Black color shades from darkest to lightest
  @override
  DSColor get shade950 => this; // Pure black
  @override
  DSColor get shade900 => this;
  @override
  DSColor get shade800 => this;
  @override
  DSColor get shade700 => this;
  @override
  DSColor get shade600 => this;
  @override
  DSColor get shade500 => this;

  // Black color tints (getting lighter)
  @override
  DSColor get shade400 => this;
  @override
  DSColor get shade300 => this;
  @override
  DSColor get shade200 => this;
  @override
  DSColor get shade100 => this;
  @override
  DSColor get shade50 => this;

  // You might want to add a more semantic name for the primary shade
  @override
  DSColor get primary => this;

  @override
  DSColor withOpacity(double opacity) {
    return this;
  }
}
