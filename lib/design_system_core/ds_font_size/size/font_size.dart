part of '../ds_font_size_core.dart';

abstract class DSFontSize {
  final double fontSize;
  final double lineHeight;
  final double letterSpacing;

  const DSFontSize({
    required this.fontSize,
    required this.lineHeight,
    required this.letterSpacing,
  });
}
