part of '../../../ds_colors_core.dart';

class DSColorUsages extends _DSColorUsages {
  const DSColorUsages();

  static ColorUsage get border => const _BorderColorUsage();
  static ColorUsage get background => const _BackgroundColorUsage();
  static ColorUsage get icon => const _IconColorUsage();
  static ColorUsage get text => const _TextColorUsage();
}
