part of '../../ds_theme.dart';

class DSChipThemeExtension extends ThemeExtension<DSChipThemeExtension> {
  final DSTextTheme textTheme;

  DSChipThemeExtension({required this.textTheme});

  DSChipTheme _dSWhiteChipTheme(DSChipStates state) {
    final defaultState = DSChipTheme(
      backgroundColor: DSColorUsages.background.primary,
      borderColor: DSColorUsages.border.secondary,
      textColor: DSColorUsages.text.primary,
      iconColor: DSColorUsages.icon.primary,
      badgeVariant: DSBadgeNotificationVariants.secondary,
    );
    final selectedState = DSChipTheme(
      backgroundColor: DSColorUsages.background.primary,
      borderColor: DSColorUsages.border.brand,
      textColor: DSColorUsages.text.linkRed,
      iconColor: DSColorUsages.icon.brand,
      badgeVariant: DSBadgeNotificationVariants.primary,
    );
    final disableState = DSChipTheme(
      backgroundColor: DSColorUsages.background.disable,
      borderColor: DSColorUsages.border.secondary,
      textColor: DSColorUsages.text.disable,
      iconColor: DSColorUsages.icon.disable,
      badgeVariant: DSBadgeNotificationVariants.secondary,
    );

    return switch (state) {
      DSChipStates.defaultState => defaultState,
      DSChipStates.selectedState => selectedState,
      DSChipStates.disableState => disableState,
    };
  }

  DSChipTheme _dSGrayChipTheme(DSChipStates state) {
    final defaultState = DSChipTheme(
      backgroundColor: DSColorUsages.background.secondary,
      borderColor: DSColorUsages.border.secondary,
      textColor: DSColorUsages.text.primary,
      iconColor: DSColorUsages.icon.primary,
      badgeVariant: DSBadgeNotificationVariants.secondary,
    );
    final selectedState = DSChipTheme(
      backgroundColor: DSColorUsages.background.brandSecondary,
      borderColor: DSColorUsages.border.brand,
      textColor: DSColorUsages.text.linkRed,
      iconColor: DSColorUsages.icon.brand,
      badgeVariant: DSBadgeNotificationVariants.primary,
    );
    final disableState = DSChipTheme(
      backgroundColor: DSColorUsages.background.disable,
      borderColor: DSColorUsages.border.secondary,
      textColor: DSColorUsages.text.disable,
      iconColor: DSColorUsages.icon.disable,
      badgeVariant: DSBadgeNotificationVariants.secondary,
    );

    return switch (state) {
      DSChipStates.defaultState => defaultState,
      DSChipStates.selectedState => selectedState,
      DSChipStates.disableState => disableState,
    };
  }

  DSChipTheme _dSBrandChipTheme(DSChipStates state) {
    final defaultState = DSChipTheme(
      backgroundColor: DSColorUsages.background.brandPrimary,
      borderColor: DSColorUsages.border.brand,
      textColor: DSColorUsages.text.white,
      iconColor: DSColorUsages.icon.white,
      badgeVariant: DSBadgeNotificationVariants.tertiary,
    );
    final selectedState = DSChipTheme(
      backgroundColor: const DSColors().orange.shade700,
      borderColor: const DSColors().orange.shade700,
      textColor: DSColorUsages.text.white,
      iconColor: DSColorUsages.icon.white,
      badgeVariant: DSBadgeNotificationVariants.tertiary,
    );
    final disableState = DSChipTheme(
      backgroundColor: const DSColors().brand.shape50,
      borderColor: const DSColors().brand.shape50,
      textColor: const DSColors().brand.shape400,
      iconColor: const DSColors().brand.shape400,
      badgeVariant: DSBadgeNotificationVariants.primary,
    );

    return switch (state) {
      DSChipStates.defaultState => defaultState,
      DSChipStates.selectedState => selectedState,
      DSChipStates.disableState => disableState,
    };
  }

  DSChipTheme getDSChipTheme(DSChipStyles style, DSChipStates state) {
    switch (style) {
      case DSChipStyles.whiteStyle:
        return _dSWhiteChipTheme(state);
      case DSChipStyles.grayStyle:
        return _dSGrayChipTheme(state);
      case DSChipStyles.brandStyle:
        return _dSBrandChipTheme(state);
    }
  }

  @override
  ThemeExtension<DSChipThemeExtension> copyWith({
    DSTextTheme? textTheme,
  }) {
    return DSChipThemeExtension(textTheme: textTheme ?? this.textTheme);
  }

  @override
  ThemeExtension<DSChipThemeExtension> lerp(
    covariant DSChipThemeExtension? other,
    double t,
  ) {
    return DSChipThemeExtension(
      textTheme: textTheme.lerp(other?.textTheme, t),
    );
  }
}
