// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../ds_theme.dart';

class DSTextStyle extends TextStyle {
  // final DSTextStyleVariant variant;
  // final DSTextStyleSize size;

  DSTextStyle({
    super.backgroundColor,
    super.fontSize,
    super.fontWeight,
    super.height,
    super.letterSpacing,
    super.textBaseline,
    super.locale,
    super.foreground,
    super.background,
    super.fontStyle,
    super.fontFamily,
    super.fontFamilyFallback,
    super.fontFeatures,
    super.fontVariations,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.shadows,
    Color? color,
    super.inherit,
    super.leadingDistribution,
    super.overflow,
    super.package,
    super.wordSpacing,
  }) : super(
          color: color ?? DSColorUsages.text.primary,
        );

  DSTextStyle.fromVariantAndSize(
    DSTextStyleVariant? variant,
    DSTextStyleSize? size,
  ) : super(
          fontWeight: variant?.fontWeight,
          fontSize: size?.dsFontSize.fontSize,
          letterSpacing: size?.dsFontSize.letterSpacing.value,
          color: DSColorUsages.text.primary,
          height: size?.dsFontSize.lineHeight.value,
        );

  DSTextStyle.fromSize(DSTextStyleSize size)
      : super(
          fontSize: size.dsFontSize.fontSize,
          letterSpacing: size.dsFontSize.letterSpacing.value,
          color: DSColorUsages.text.primary,
          height: size.dsFontSize.lineHeight.value / size.dsFontSize.fontSize,
        );

  DSTextStyle.fromTextStyle(TextStyle? textStyle)
      : super(
          fontWeight: textStyle?.fontWeight,
          fontSize: textStyle?.fontSize,
          letterSpacing: textStyle?.letterSpacing,
          height: textStyle?.height,
          background: textStyle?.background,
          backgroundColor: textStyle?.backgroundColor,
          color: textStyle?.color,
          decoration: textStyle?.decoration,
          decorationColor: textStyle?.decorationColor,
          decorationStyle: textStyle?.decorationStyle,
          decorationThickness: textStyle?.decorationThickness,
          debugLabel: textStyle?.debugLabel,
          fontFamily: textStyle?.fontFamily,
          fontFamilyFallback: textStyle?.fontFamilyFallback,
          fontFeatures: textStyle?.fontFeatures,
          fontVariations: textStyle?.fontVariations,
          foreground: textStyle?.foreground,
          locale: textStyle?.locale,
          fontStyle: textStyle?.fontStyle,
          shadows: textStyle?.shadows,
          textBaseline: textStyle?.textBaseline,
          inherit: textStyle?.inherit ?? true,
          leadingDistribution: textStyle?.leadingDistribution,
          overflow: textStyle?.overflow,
          package: 'design_system_project',
          wordSpacing: textStyle?.wordSpacing,
        );

  DSTextStyle lerp(DSTextStyle? a, DSTextStyle? b, double t) {
    return DSTextStyle.fromTextStyle(TextStyle.lerp(a, b, t));
  }

  DSTextStyle copyWithVariant(DSTextStyleVariant variant) {
    return DSTextStyle.fromTextStyle(copyWith(fontWeight: variant.fontWeight));
  }

  DSTextStyle copyWithSize(DSTextStyleSize size) {
    return DSTextStyle.fromTextStyle(
      copyWith(
        fontSize: size.dsFontSize.fontSize,
        letterSpacing: size.dsFontSize.letterSpacing.value,
        height: size.dsFontSize.lineHeight.value / size.dsFontSize.fontSize,
      ),
    );
  }

  DSTextStyle copyWithColor(DSColor? color) {
    return DSTextStyle.fromTextStyle(copyWith(color: color));
  }

  DSTextStyle custom({
    required double fontSize,
  }) {
    return DSTextStyle(
      fontSize: fontSize,
    );
  }
}

extension DSTextStyleExtension on DSTextStyle {
  DSTextStyle get bold => copyWithVariant(DSTextStyleVariant.bold);
  DSTextStyle get semibold => copyWithVariant(DSTextStyleVariant.semibold);
  DSTextStyle get medium => copyWithVariant(DSTextStyleVariant.medium);
  DSTextStyle get regular => copyWithVariant(DSTextStyleVariant.regular);
  DSTextStyle get underline => copyWithVariant(DSTextStyleVariant.underline);
}

class DSTextTheme extends TextTheme {
  final DSTextStyle? xxs;
  final DSTextStyle? xs;
  final DSTextStyle? sm;
  final DSTextStyle? base;
  final DSTextStyle? lg;
  final DSTextStyle? xl;
  final DSTextStyle? xxl;
  final DSTextStyle? xxxl;
  final DSTextStyle? xxxxl;
  final DSTextStyle? xxxxxl;

  DSTextTheme({
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.base,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.xxxxl,
    required this.xxxxxl,
  });

  factory DSTextTheme._create() {
    return DSTextTheme(
      xxs: DSTextStyle.fromSize(DSTextStyleSize.xxs),
      xs: DSTextStyle.fromSize(DSTextStyleSize.xs),
      sm: DSTextStyle.fromSize(DSTextStyleSize.sm),
      base: DSTextStyle.fromSize(DSTextStyleSize.base),
      lg: DSTextStyle.fromSize(DSTextStyleSize.lg),
      xl: DSTextStyle.fromSize(DSTextStyleSize.xl),
      xxl: DSTextStyle.fromSize(DSTextStyleSize.xxl),
      xxxl: DSTextStyle.fromSize(DSTextStyleSize.xxxl),
      xxxxl: DSTextStyle.fromSize(DSTextStyleSize.xxxxl),
      xxxxxl: DSTextStyle.fromSize(DSTextStyleSize.xxxxxl),
    );
  }

  @override
  bool operator ==(covariant DSTextTheme other) {
    if (identical(this, other)) {
      return true;
    }

    return other.xs == xs &&
        other.sm == sm &&
        other.base == base &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl &&
        other.xxxl == xxxl &&
        other.xxxxl == xxxxl &&
        other.xxxxxl == xxxxxl;
  }

  @override
  int get hashCode {
    return xs.hashCode ^
        sm.hashCode ^
        base.hashCode ^
        lg.hashCode ^
        xl.hashCode ^
        xxl.hashCode ^
        xxxl.hashCode ^
        xxxxl.hashCode ^
        xxxxxl.hashCode;
  }

  DSTextTheme lerp(covariant DSTextTheme? other, double t) {
    return DSTextTheme(
      xxs: xxs?.lerp(xxs, other?.xxs, t),
      xs: xs?.lerp(xs, other?.xs, t),
      sm: sm?.lerp(sm, other?.sm, t),
      base: base?.lerp(base, other?.base, t),
      lg: lg?.lerp(lg, other?.lg, t),
      xl: xl?.lerp(xl, other?.xl, t),
      xxl: xxl?.lerp(xxl, other?.xxl, t),
      xxxl: xxxl?.lerp(xxxl, other?.xxxl, t),
      xxxxl: xxxxl?.lerp(xxxxl, other?.xxxxl, t),
      xxxxxl: xxxxxl?.lerp(xxxxxl, other?.xxxxxl, t),
    );
  }
}
