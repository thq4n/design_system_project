part of '../../ds_colors_core.dart';

class _DSOtherColor extends DSColor {
  const _DSOtherColor([super.value = 0xFFFFFFFF]);

  @override
  DSColor get black => const _DSBlueColor(0xFF000000);

  @override
  DSColor get white => const _DSBlueColor(0xFFFFFFFF);

  @override
  DSColor get shade500 => throw UnimplementedError();

  @override
  DSColor get shade600 => throw UnimplementedError();

  @override
  DSColor get shade700 => throw UnimplementedError();

  @override
  DSColor get shade800 => throw UnimplementedError();

  @override
  DSColor get shade900 => throw UnimplementedError();

  @override
  DSColor get shade950 => throw UnimplementedError();

  @override
  DSColor get shade100 => throw UnimplementedError();

  @override
  DSColor get shade200 => throw UnimplementedError();

  @override
  DSColor get shade300 => throw UnimplementedError();

  @override
  DSColor get shade400 => throw UnimplementedError();

  @override
  DSColor get shade50 => throw UnimplementedError();

  @override
  DSColor withOpacity(double opacity) {
    return _DSOtherColor(withValues(alpha: opacity).toARGB32());
  }
}
