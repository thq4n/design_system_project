part of '../constants.dart';

enum DSTextStyleVariant {
  bold,
  semibold,
  medium,
  regular,
  underline;

  FontWeight get fontWeight {
    switch (this) {
      case DSTextStyleVariant.bold:
        return DSFontWeights.bold.value;
      case DSTextStyleVariant.semibold:
        return DSFontWeights.semiBold.value;
      case DSTextStyleVariant.medium:
        return DSFontWeights.medium.value;
      case DSTextStyleVariant.regular:
        return DSFontWeights.regular.value;
      case DSTextStyleVariant.underline:
        return DSFontWeights.regular.value;
    }
  }
}

enum DSTextStyleSize {
  xs,
  sm,
  base,
  lg,
  xl,
  xxl,
  xxxl,
  xxxxl,
  xxxxxl;

  DSFontSize get dsFontSize {
    switch (this) {
      case DSTextStyleSize.xs:
        return DSFontSizes.xs;
      case DSTextStyleSize.sm:
        return DSFontSizes.sm;
      case DSTextStyleSize.base:
        return DSFontSizes.base;
      case DSTextStyleSize.lg:
        return DSFontSizes.lg;
      case DSTextStyleSize.xl:
        return DSFontSizes.xl;
      case DSTextStyleSize.xxl:
        return DSFontSizes.xxl;
      case DSTextStyleSize.xxxl:
        return DSFontSizes.xxxl;
      case DSTextStyleSize.xxxxl:
        return DSFontSizes.xxxxl;
      case DSTextStyleSize.xxxxxl:
        return DSFontSizes.xxxxxl;
    }
  }
}
