part of '../../ds_colors_core.dart';

class _DSGreenColor extends DSColor {
  const _DSGreenColor([super.value = 0xFF17B26A]);

  @override
  DSColor get shade950 => const _DSGreenColor(0xFF053321);
  @override
  DSColor get shade900 => const _DSGreenColor(0xFF074D31);
  @override
  DSColor get shade800 => const _DSGreenColor(0xFF085D3A);
  @override
  DSColor get shade700 => const _DSGreenColor(0xFF067647);
  @override
  DSColor get shade600 => const _DSGreenColor(0xFF079455);
  @override
  DSColor get shade500 => const _DSGreenColor(0xFF17B26A); // Primary Green
  @override
  DSColor get tint400 => const _DSGreenColor(0xFF47CD89);
  @override
  DSColor get tint300 => const _DSGreenColor(0xFF75E0A7);
  @override
  DSColor get tint200 => const _DSGreenColor(0xFFABEFC6);
  @override
  DSColor get tint100 => const _DSGreenColor(0xFFDCFAE8);
  @override
  DSColor get tint50 => const _DSGreenColor(0xFFECFDF3);

  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSGreenColor(withValues(alpha: opacity).toARGB32());
  }
}
