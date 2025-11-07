part of '../../ds_theme.dart';

enum DSTagStyles { error, success, custom, default_, brand, info }

enum DSTagSizes {
  sm,
  md,
}

class DSTagTheme {
  final DSColor? mainColor;
  final DSRadius borderRadius;
  final EdgeInsets? padding;
  final DSTextStyle? textStyle;
  final double? iconSize;
  final double? elementSpacing;

  DSTagTheme({
    this.mainColor,
    required this.borderRadius,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.elementSpacing,
  });
}
