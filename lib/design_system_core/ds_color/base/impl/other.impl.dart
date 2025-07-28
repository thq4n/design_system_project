part of '../../ds_colors_core.dart';

class _DSOtherColor extends DSColor {
  const _DSOtherColor([super.value = 0xFFFFFFFF]);

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
  DSColor get tint100 => throw UnimplementedError();

  @override
  DSColor get tint200 => throw UnimplementedError();

  @override
  DSColor get tint300 => throw UnimplementedError();

  @override
  DSColor get tint400 => throw UnimplementedError();

  @override
  DSColor get tint50 => throw UnimplementedError();

  @override
  DSColor withOpacity(double opacity) {
    return _DSOtherColor(withValues(alpha: opacity).toARGB32());
  }
}
