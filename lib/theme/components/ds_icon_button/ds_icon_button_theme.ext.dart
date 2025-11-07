part of '../../ds_theme.dart';

enum DSIconButtonVariants {
  primary,
  secondary,
  tertiary,
  // ghost,
}

enum DSIconButtonSize {
  lg(
    padding: EdgeInsets.all(16),
    iconSize: 24,
  ),
  md(
    padding: EdgeInsets.all(12),
    iconSize: 24,
  ),
  sm(
    padding: EdgeInsets.all(8),
    iconSize: 24,
  ),
  xs(
    padding: EdgeInsets.all(6),
    iconSize: 24,
  );

  final EdgeInsets padding;
  final double iconSize;

  const DSIconButtonSize({
    required this.padding,
    required this.iconSize,
  });
}

class DSIconButtonThemeExtension
    extends ThemeExtension<DSIconButtonThemeExtension> {
  DSIconButtonTheme get dSPrimaryButtonTheme => DSIconButtonTheme(
        defaultState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.brandPrimary,
          iconColor: DSColorUsages.icon.white,
        ),
        pressedState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.brandPrimary.shade600,
          iconColor: DSColorUsages.icon.white,
        ),
        activeState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.brandPrimary.shade700,
          iconColor: DSColorUsages.icon.white,
        ),
        disableState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.disable,
          iconColor: DSColorUsages.icon.disable,
        ),
      );

  DSIconButtonTheme get dSSecondaryButtonTheme => DSIconButtonTheme(
        defaultState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.brandSecondary.shape200,
          iconColor: DSColorUsages.icon.brand.shade600,
        ),
        pressedState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.brandSecondary.shape300,
          iconColor: DSColorUsages.icon.brand.shade600,
        ),
        activeState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.brandSecondary.shape400,
          iconColor: DSColorUsages.icon.brand.shade600,
        ),
        disableState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.disable,
          iconColor: DSColorUsages.icon.disable,
        ),
      );

  DSIconButtonTheme get dSTertiaryButtonTheme => DSIconButtonTheme(
        defaultState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.secondary,
          iconColor: DSColorUsages.icon.solid,
        ),
        pressedState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.secondary.shape200,
          iconColor: DSColorUsages.icon.solid,
        ),
        activeState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.secondary.shape300,
          iconColor: DSColorUsages.icon.solid,
        ),
        disableState: DSIconButtonStateTheme(
          backgroundColor: DSColorUsages.background.disable,
          iconColor: DSColorUsages.icon.disable,
        ),
      );

  // DSIconButtonTheme get dSGhostButtonTheme => DSIconButtonTheme(
  //       defaultState: DSIconButtonStateTheme(
  //         backgroundColor: DSColorUsages.background.transparent,
  //       ),
  //       pressedState: DSIconButtonStateTheme(
  //         backgroundColor: DSColorUsages.background.transparent,
  //       ),
  //       activeState: DSIconButtonStateTheme(
  //         backgroundColor: DSColorUsages.background.transparent,
  //       ),
  //       disableState: DSIconButtonStateTheme(
  //         backgroundColor: DSColorUsages.background.disable,
  //       ),
  //     );

  DSIconButtonTheme getDSPrimaryButtonTheme(DSIconButtonVariants variant) {
    switch (variant) {
      case DSIconButtonVariants.primary:
        return dSPrimaryButtonTheme;
      case DSIconButtonVariants.secondary:
        return dSSecondaryButtonTheme;
      case DSIconButtonVariants.tertiary:
        return dSTertiaryButtonTheme;
      // case DSIconButtonVariants.ghost:
      //   return dSGhostButtonTheme;
    }
  }

  @override
  ThemeExtension<DSIconButtonThemeExtension> copyWith() {
    return DSIconButtonThemeExtension();
  }

  @override
  ThemeExtension<DSIconButtonThemeExtension> lerp(
    covariant ThemeExtension<DSIconButtonThemeExtension>? other,
    double t,
  ) {
    return DSIconButtonThemeExtension();
  }
}
