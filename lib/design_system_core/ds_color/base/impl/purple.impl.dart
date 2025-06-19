part of '../../ds_colors_core.dart';

class _DSPurpleColor extends DSColor {
  const _DSPurpleColor([super.value = 0xFFA855F7]);

  @override
  DSColor get shade950 => const _DSPurpleColor(0xFF3B0764);
  @override
  DSColor get shade900 => const _DSPurpleColor(0xFF581C87);
  @override
  DSColor get shade800 => const _DSPurpleColor(0xFF6B21A8);
  @override
  DSColor get shade700 => const _DSPurpleColor(0xFF7E22CE);
  @override
  DSColor get shade600 => const _DSPurpleColor(0xFF9333EA);
  @override
  DSColor get shade500 => const _DSPurpleColor(0xFFA855F7); // Primary Purple
  @override
  DSColor get tint400 => const _DSPurpleColor(0xFFC084FC);
  @override
  DSColor get tint300 => const _DSPurpleColor(0xFFD6B4FE);
  @override
  DSColor get tint200 => const _DSPurpleColor(0xFFE9D5FF);
  @override
  DSColor get tint100 => const _DSPurpleColor(0xFFF3E8FF);
  @override
  DSColor get tint50 => const _DSPurpleColor(0xFFFAF5FF);

  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSPurpleColor(withValues(alpha: opacity).toARGB32());
  }
}
