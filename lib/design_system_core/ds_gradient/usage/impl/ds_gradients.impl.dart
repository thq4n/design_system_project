part of '../../ds_gradients_core.dart';

class DSGradients extends _DSGradients {
  const DSGradients();

  // Red
  LinearGradient get red1 => const _DSRedGradient1().linearGradient;
  LinearGradient get red2 => const _DSRedGradient2().linearGradient;
  LinearGradient get red3 => const _DSRedGradient3().linearGradient;
  LinearGradient get red4 => const _DSRedGradient4().linearGradient;

  // Green
  LinearGradient get green1 => const _DSGreenGradient1().linearGradient;
  LinearGradient get green2 => const _DSGreenGradient2().linearGradient;

  // Yellow
  LinearGradient get yellow1 => const _DSYellowGradient1().linearGradient;
  LinearGradient get yellow2 => const _DSYellowGradient2().linearGradient;

  /// Custom gradient using the same angle → alignment rules as design tokens.
  LinearGradient create({
    required List<Color> colors,
    required List<double> stops,
    double angle = -45,
    Alignment? begin,
    Alignment? end,
  }) {
    return DSGradient.create(
      colors: colors,
      stops: stops,
      angle: angle,
      begin: begin,
      end: end,
    );
  }
}
