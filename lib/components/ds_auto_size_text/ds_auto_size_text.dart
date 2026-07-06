import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../design_system_core/ds_font_size/ds_font_size_core.dart';

class DSAutoSizeText extends StatelessWidget {
  const DSAutoSizeText(
    this.data, {
    super.key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize,
    this.maxFontSize,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }) : textSpan = null;

  const DSAutoSizeText.rich(
    this.textSpan, {
    super.key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize,
    this.maxFontSize,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.group,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.overflowReplacement,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }) : data = null;

  final String? data;
  final TextSpan? textSpan;
  final Key? textKey;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final double? minFontSize;
  final double? maxFontSize;
  final double stepGranularity;
  final List<double>? presetFontSizes;
  final AutoSizeGroup? group;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final bool wrapWords;
  final TextOverflow? overflow;
  final Widget? overflowReplacement;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;

  double get _resolvedMinFontSize =>
      minFontSize ?? DSFontSizes.xxs.fontSize;

  double get _resolvedMaxFontSize =>
      maxFontSize ?? DSFontSizes.xxxxxl.fontSize;

  @override
  Widget build(BuildContext context) {
    if (textSpan != null) {
      return AutoSizeText.rich(
        textSpan!,
        key: key,
        textKey: textKey,
        style: style,
        strutStyle: strutStyle,
        minFontSize: _resolvedMinFontSize,
        maxFontSize: _resolvedMaxFontSize,
        stepGranularity: stepGranularity,
        presetFontSizes: presetFontSizes,
        group: group,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        wrapWords: wrapWords,
        overflow: overflow,
        overflowReplacement: overflowReplacement,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      );
    }

    return AutoSizeText(
      data!,
      key: key,
      textKey: textKey,
      style: style,
      strutStyle: strutStyle,
      minFontSize: _resolvedMinFontSize,
      maxFontSize: _resolvedMaxFontSize,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
      group: group,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      wrapWords: wrapWords,
      overflow: overflow,
      overflowReplacement: overflowReplacement,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}
