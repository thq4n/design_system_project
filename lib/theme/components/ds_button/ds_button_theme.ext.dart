part of '../../ds_theme.dart';

enum DSButtonVariants {
  primary,
  secondary,
  tertiary,
  ghostBrand,
  ghostGrey,
}

enum DSButtonSize {
  lg(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    elementSpacing: 8,
    prefixIconSize: 24,
    suffixIconSize: 24,
  ),
  md(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    elementSpacing: 8,
    prefixIconSize: 24,
    suffixIconSize: 24,
  ),
  sm(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    elementSpacing: 6,
    prefixIconSize: 24,
    suffixIconSize: 24,
  ),
  xs(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    elementSpacing: 4,
    prefixIconSize: 20,
    suffixIconSize: 20,
  );

  final double elementSpacing;
  final EdgeInsets padding;
  final double prefixIconSize;
  final double suffixIconSize;

  const DSButtonSize({
    required this.elementSpacing,
    required this.padding,
    required this.prefixIconSize,
    required this.suffixIconSize,
  });
}

class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  final DSTextTheme textTheme;

  DSButtonThemeExtension({required this.textTheme});

  DSButtonTheme get dSPrimaryButtonTheme => DSButtonTheme(
        defaultState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.white),
          backgroundColor: DSColorUsages.background.brandPrimary,
          prefixIconColor: DSColorUsages.icon.white,
          suffixIconColor: DSColorUsages.icon.white,
        ),
        pressedState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.white),
          backgroundColor: DSColorUsages.background.brandPrimary.shade600,
          prefixIconColor: DSColorUsages.icon.white,
          suffixIconColor: DSColorUsages.icon.white,
        ),
        activeState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.white),
          backgroundColor: DSColorUsages.background.brandPrimary.shade700,
          prefixIconColor: DSColorUsages.icon.white,
          suffixIconColor: DSColorUsages.icon.white,
        ),
        disableState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.disable),
          backgroundColor: DSColorUsages.background.disable,
          prefixIconColor: DSColorUsages.icon.disable,
          suffixIconColor: DSColorUsages.icon.disable,
        ),
      );

  DSButtonTheme get dSSecondaryButtonTheme => DSButtonTheme(
        defaultState: DSButtonStateTheme(
          textStyle: textTheme.base?.bold
              .copyWithColor(DSColorUsages.text.linkRed.shade600),
          backgroundColor: DSColorUsages.background.brandSecondary.tint200,
          prefixIconColor: DSColorUsages.icon.brand.shade600,
          suffixIconColor: DSColorUsages.icon.brand.shade600,
        ),
        pressedState: DSButtonStateTheme(
          textStyle: textTheme.base?.bold
              .copyWithColor(DSColorUsages.text.linkRed.shade600),
          backgroundColor: DSColorUsages.background.brandSecondary.tint300,
          prefixIconColor: DSColorUsages.icon.brand.shade600,
          suffixIconColor: DSColorUsages.icon.brand.shade600,
        ),
        activeState: DSButtonStateTheme(
          textStyle: textTheme.base?.bold
              .copyWithColor(DSColorUsages.text.linkRed.shade600),
          backgroundColor: DSColorUsages.background.brandSecondary.tint400,
          prefixIconColor: DSColorUsages.icon.brand.shade600,
          suffixIconColor: DSColorUsages.icon.brand.shade600,
        ),
        disableState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.disable),
          backgroundColor: DSColorUsages.background.disable,
          prefixIconColor: DSColorUsages.icon.disable,
          suffixIconColor: DSColorUsages.icon.disable,
        ),
      );

  DSButtonTheme get dSTertiaryButtonTheme => DSButtonTheme(
        defaultState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.primary),
          backgroundColor: DSColorUsages.background.secondary,
          prefixIconColor: DSColorUsages.icon.primary,
          suffixIconColor: DSColorUsages.icon.primary,
        ),
        pressedState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.primary),
          backgroundColor: DSColorUsages.background.secondary.tint200,
          prefixIconColor: DSColorUsages.icon.primary,
          suffixIconColor: DSColorUsages.icon.primary,
        ),
        activeState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.primary),
          backgroundColor: DSColorUsages.background.secondary.tint300,
          prefixIconColor: DSColorUsages.icon.primary,
          suffixIconColor: DSColorUsages.icon.primary,
        ),
        disableState: DSButtonStateTheme(
          textStyle:
              textTheme.base?.bold.copyWithColor(DSColorUsages.text.disable),
          backgroundColor: DSColorUsages.background.disable,
          prefixIconColor: DSColorUsages.icon.disable,
          suffixIconColor: DSColorUsages.icon.disable,
        ),
      );

  DSButtonTheme get dSGhostBrandButtonTheme => DSButtonTheme(
        defaultState: DSButtonStateTheme(
          textStyle: textTheme.sm?.bold
              .copyWithColor(DSColorUsages.text.linkRed.shade500),
          backgroundColor: DSColorUsages.background.transparent,
          prefixIconColor: DSColorUsages.icon.brand.shade500,
          suffixIconColor: DSColorUsages.icon.brand.shade500,
        ),
        pressedState: DSButtonStateTheme(
          textStyle: textTheme.sm?.bold
              .copyWithColor(DSColorUsages.text.linkRed.shade600),
          backgroundColor: DSColorUsages.background.transparent,
          prefixIconColor: DSColorUsages.icon.brand.shade600,
          suffixIconColor: DSColorUsages.icon.brand.shade600,
        ),
        activeState: DSButtonStateTheme(
          textStyle: textTheme.sm?.bold
              .copyWithColor(DSColorUsages.text.linkRed.shade700),
          backgroundColor: DSColorUsages.background.transparent,
          prefixIconColor: DSColorUsages.icon.brand.shade700,
          suffixIconColor: DSColorUsages.icon.brand.shade700,
        ),
        disableState: DSButtonStateTheme(
          textStyle:
              textTheme.sm?.bold.copyWithColor(DSColorUsages.text.disable),
          backgroundColor: DSColorUsages.background.disable,
          prefixIconColor: DSColorUsages.icon.disable,
          suffixIconColor: DSColorUsages.icon.disable,
        ),
      );

  DSButtonTheme get dSGhostGreyButtonTheme => DSButtonTheme(
        defaultState: DSButtonStateTheme(
          textStyle:
              textTheme.sm?.bold.copyWithColor(DSColorUsages.text.primary),
          backgroundColor: DSColorUsages.background.transparent,
          prefixIconColor: DSColorUsages.icon.primary,
          suffixIconColor: DSColorUsages.icon.primary,
        ),
        pressedState: DSButtonStateTheme(
          textStyle:
              textTheme.sm?.bold.copyWithColor(DSColorUsages.text.primary),
          backgroundColor: DSColorUsages.background.transparent,
          prefixIconColor: DSColorUsages.icon.primary,
          suffixIconColor: DSColorUsages.icon.primary,
        ),
        activeState: DSButtonStateTheme(
          textStyle:
              textTheme.sm?.bold.copyWithColor(DSColorUsages.text.primary),
          backgroundColor: DSColorUsages.background.transparent,
          prefixIconColor: DSColorUsages.icon.primary,
          suffixIconColor: DSColorUsages.icon.primary,
        ),
        disableState: DSButtonStateTheme(
          textStyle:
              textTheme.sm?.bold.copyWithColor(DSColorUsages.text.disable),
          backgroundColor: DSColorUsages.background.disable,
          prefixIconColor: DSColorUsages.icon.disable,
          suffixIconColor: DSColorUsages.icon.disable,
        ),
      );

  DSButtonTheme getDSButtonTheme(DSButtonVariants variant) {
    switch (variant) {
      case DSButtonVariants.primary:
        return dSPrimaryButtonTheme;
      case DSButtonVariants.secondary:
        return dSSecondaryButtonTheme;
      case DSButtonVariants.tertiary:
        return dSTertiaryButtonTheme;
      case DSButtonVariants.ghostBrand:
        return dSGhostBrandButtonTheme;
      case DSButtonVariants.ghostGrey:
        return dSGhostGreyButtonTheme;
    }
  }

  @override
  ThemeExtension<DSButtonThemeExtension> copyWith({
    DSTextTheme? textTheme,
  }) {
    return DSButtonThemeExtension(textTheme: textTheme ?? this.textTheme);
  }

  @override
  ThemeExtension<DSButtonThemeExtension> lerp(
    covariant DSButtonThemeExtension? other,
    double t,
  ) {
    return DSButtonThemeExtension(
      textTheme: textTheme.lerp(other?.textTheme, t),
    );
  }
}
