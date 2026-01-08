part of '../../ds_theme.dart';

class DSExpandableTheme {
  final DSColor iconColor;
  final double iconSize;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry bodyPadding;
  final DSRadius borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  DSExpandableTheme({
    required this.iconColor,
    required this.iconSize,
    required this.headerPadding,
    required this.bodyPadding,
    required this.borderRadius,
    required this.animationDuration,
    required this.animationCurve,
  });
}
