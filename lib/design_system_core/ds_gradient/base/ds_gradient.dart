part of '../ds_gradients_core.dart';

/// Design-system linear gradient token.
///
/// Mirrors [DSColor.createGradient] (colors / stops / angle) as a reusable
/// token that resolves to a Flutter [LinearGradient].
abstract class DSGradient {
  const DSGradient();

  List<Color> get colors;
  List<double> get stops;

  /// CSS-style angle in degrees. `0` = to top, positive = clockwise.
  /// Defaults to `-45` to match design tokens.
  double get angle => -45;

  Alignment get begin => alignmentFromCssAngle(angle, isBegin: true);

  Alignment get end => alignmentFromCssAngle(angle, isBegin: false);

  LinearGradient get linearGradient => LinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
      );

  /// Converts a CSS `linear-gradient` angle to a Flutter [Alignment].
  static Alignment alignmentFromCssAngle(
    double degrees, {
    required bool isBegin,
  }) {
    final rad = degrees * math.pi / 180;
    final x = math.sin(rad);
    final y = -math.cos(rad);
    return isBegin ? Alignment(-x, -y) : Alignment(x, y);
  }

  /// Factory used by [DSColor.createGradient] and custom callers.
  static LinearGradient create({
    required List<Color> colors,
    required List<double> stops,
    double angle = -45,
    Alignment? begin,
    Alignment? end,
  }) {
    return LinearGradient(
      colors: colors,
      stops: stops,
      begin: begin ?? alignmentFromCssAngle(angle, isBegin: true),
      end: end ?? alignmentFromCssAngle(angle, isBegin: false),
    );
  }
}
