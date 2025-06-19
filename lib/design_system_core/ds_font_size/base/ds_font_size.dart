part of '../ds_font_size_core.dart';

abstract class DSFontSize {
  final double fontSize;
  final DSLineHeight lineHeight;
  final DSLetterSpacing letterSpacing;

  const DSFontSize({
    required this.fontSize,
    required this.lineHeight,
    required this.letterSpacing,
  });
}
