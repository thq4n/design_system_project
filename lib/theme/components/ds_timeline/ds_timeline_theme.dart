part of '../../ds_theme.dart';

class DSTimelineTheme {
  final DSColor dotColor;
  final DSColor dotBorderColor;
  final double dotSize;
  final double dotBorderThickness;
  final DSColor connectorColor;
  final double connectorThickness;
  final double itemSpacing;
  final Duration animationDuration;
  final Duration animationDelay;
  final EdgeInsetsGeometry padding;
  final double horizontalSpacing;
  final DSColor separatorLineColor;
  final double separatorLineThickness;
  final EdgeInsetsGeometry separatorPadding;
  final DSTextStyle? separatorTextStyle;

  DSTimelineTheme({
    required this.dotColor,
    required this.dotBorderColor,
    required this.dotSize,
    required this.dotBorderThickness,
    required this.connectorColor,
    required this.connectorThickness,
    required this.itemSpacing,
    required this.animationDuration,
    required this.animationDelay,
    required this.padding,
    required this.horizontalSpacing,
    required this.separatorLineColor,
    required this.separatorLineThickness,
    required this.separatorPadding,
    this.separatorTextStyle,
  });
}
