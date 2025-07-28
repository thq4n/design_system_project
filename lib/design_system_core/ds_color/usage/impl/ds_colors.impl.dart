part of '../../ds_colors_core.dart';

class DSColors extends _DSColors {
  const DSColors();

  DSColor get brand => const _DSBrandColor();
  DSColor get gray => const _DSGrayColor();
  DSColor get blue => const _DSBlueColor();
  DSColor get orange => const _DSOrangeColor();
  DSColor get green => const _DSGreenColor();
  DSColor get purple => const _DSPurpleColor();
  DSColor get white => const _DSWhiteColor();
  DSColor get black => const _DSBlackColor();
  DSColor get transparent => const _DSTransparentColor();
  DSColor get other => const _DSOtherColor();

  DSColors lerp(DSColors? other, double t) {
    return const DSColors();
  }
}
