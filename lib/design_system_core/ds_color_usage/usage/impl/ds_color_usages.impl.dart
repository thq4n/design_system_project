part of '../../ds_color_usage_core.dart';

class DSColorUsages extends _DSColorUsages {
  const DSColorUsages();

  static _DSBorderColorUsage get border => const _DSBorderColorUsage();
  static _DSBackgroundColorUsage get background =>
      const _DSBackgroundColorUsage();
  static _DSIconColorUsage get icon => const _DSIconColorUsage();
  static _DSTextColorUsage get text => const _DSTextColorUsage();
}
