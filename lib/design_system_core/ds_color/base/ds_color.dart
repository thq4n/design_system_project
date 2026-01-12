part of '../ds_colors_core.dart';

abstract class DSColor extends Color {
  const DSColor(super.value);

  DSColor get black;

  DSColor get shade950;
  DSColor get shade900;
  DSColor get shade800;
  DSColor get shade700;
  DSColor get shade600;
  DSColor get shape500;

  DSColor get shape400;
  DSColor get shape300;
  DSColor get shape200;
  DSColor get shape100;
  DSColor get shape50;

  DSColor get white;

  DSColor get primary => shape500;

  Gradient createGradient({
    required List<Color> colors,
    required List<double> stops,
    double angle = -45,
    Alignment begin = Alignment.centerLeft,
    Alignment end = Alignment.centerRight,
  }) {
    return LinearGradient(
      colors: colors,
      stops: stops,
      // transform:
      //     GradientRotation(angle * 3.14159 / 180), // Convert degrees to radians
      begin: begin,
      end: end,
    );
  }

  @override
  DSColor withOpacity(double opacity);

  static DSColor fromColor(Color color) {
    return _DSColorWrapper(color.toARGB32());
  }

  DSColor custom(int value) {
    return _DSColorWrapper(value);
  }
}

class _DSColorWrapper extends DSColor {
  const _DSColorWrapper(super.value);

  @override
  DSColor get black => this;
  @override
  DSColor get shade950 => this;
  @override
  DSColor get shade900 => this;
  @override
  DSColor get shade800 => this;
  @override
  DSColor get shade700 => this;
  @override
  DSColor get shade600 => this;
  @override
  DSColor get shape500 => this;
  @override
  DSColor get shape400 => this;
  @override
  DSColor get shape300 => this;
  @override
  DSColor get shape200 => this;
  @override
  DSColor get shape100 => this;
  @override
  DSColor get shape50 => this;
  @override
  DSColor get white => this;

  @override
  DSColor withOpacity(double opacity) {
    return _DSColorWrapper(withValues(alpha: opacity).toARGB32());
  }
}
