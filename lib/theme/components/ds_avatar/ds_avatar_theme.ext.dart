part of '../../ds_theme.dart';

class DSAvatarThemeExtension extends ThemeExtension<DSAvatarThemeExtension> {
  final DSColors dsColors = const DSColors();
  final DSTextTheme textTheme;

  DSAvatarThemeExtension({
    required this.textTheme,
  });

  DSTextStyle? getTextStyleBySize(DSAvatarSizes size) {
    switch (size) {
      case DSAvatarSizes.xs:
        return textTheme.xxs?.semibold.copyWithColor(DSColorUsages.text.white);
      case DSAvatarSizes.sm:
        return textTheme.sm?.semibold.copyWithColor(DSColorUsages.text.white);
      case DSAvatarSizes.md:
        return textTheme.lg?.semibold.copyWithColor(DSColorUsages.text.white);
      case DSAvatarSizes.lg:
        return textTheme.xl?.semibold.copyWithColor(DSColorUsages.text.white);
      case DSAvatarSizes.xl:
        return textTheme.xxxl?.semibold.copyWithColor(DSColorUsages.text.white);
      case DSAvatarSizes.xxl:
        return textTheme.xxxxxl?.semibold
            .copyWithColor(DSColorUsages.text.white);
    }
  }

  DSAvatarTheme getDSAvatarThemeByType(DSAvaterTypes type, DSAvatarSizes size) {
    switch (type) {
      case DSAvaterTypes.defaultType:
        return DSAvatarTheme(
          textColor: DSColorUsages.text.primary,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            shape: BoxShape.circle,
            border: Border.all(
              color: DSColorUsages.border.tertiary,
              width: 1,
            ),
          ),
        );
      case DSAvaterTypes.textType:
        return DSAvatarTheme(
          textColor: DSColorUsages.text.primary,
          decoration: BoxDecoration(
            color: dsColors.green.shape500,
            shape: BoxShape.circle,
            border: Border.all(
              color: DSColorUsages.border.tertiary,
              width: 1,
            ),
          ),
          textStyle: getTextStyleBySize(size),
        );
      case DSAvaterTypes.logoWhiteType:
        return DSAvatarTheme(
          textColor: DSColorUsages.text.primary,
          decoration: BoxDecoration(
            gradient: dsColors.brand.createGradient(
              colors: [
                dsColors.brand.custom(0xFFD02727),
                dsColors.brand.custom(0xFFFF3F3F),
              ],
              stops: [-0.03, 0.851], // -3% and 85.1%
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: DSColorUsages.border.tertiary,
              width: 1,
            ),
          ),
        );
      case DSAvaterTypes.logoRedType:
        return DSAvatarTheme(
          textColor: DSColorUsages.text.primary,
          decoration: BoxDecoration(
            color: DSColorUsages.icon.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: DSColorUsages.border.tertiary,
              width: 1,
            ),
          ),
        );
      case DSAvaterTypes.genderType:
        return DSAvatarTheme(
          textColor: DSColorUsages.text.primary,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            shape: BoxShape.circle,
            border: Border.all(
              color: DSColorUsages.border.tertiary,
              width: 1,
            ),
          ),
        );
    }
  }

  @override
  ThemeExtension<DSAvatarThemeExtension> copyWith() {
    return DSAvatarThemeExtension(textTheme: textTheme);
  }

  @override
  ThemeExtension<DSAvatarThemeExtension> lerp(
    covariant ThemeExtension<DSAvatarThemeExtension>? other,
    double t,
  ) {
    return DSAvatarThemeExtension(textTheme: textTheme);
  }
}
