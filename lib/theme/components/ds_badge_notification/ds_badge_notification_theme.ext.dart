part of '../../ds_theme.dart';

enum DSBadgeNotificationVariants {
  primary,
  secondary,
  tertiary,
}

enum DSBadgeNotificationSize {
  lg(
    padding: EdgeInsets.symmetric(
      horizontal: 5,
      vertical: 1,
    ),
    borderWidth: 1,
  ),

  md(
    padding: EdgeInsets.symmetric(horizontal: 4),
    borderWidth: 1,
  ),
  xs(
    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
    borderWidth: 1,
  );

  final EdgeInsets padding;
  final double borderWidth;

  DSTextStyle? getTextStyle(BuildContext context) {
    final textTheme = context.textTheme;
    switch (this) {
      case DSBadgeNotificationSize.xs:
        return textTheme.base?.medium.custom(fontSize: 8);
      case DSBadgeNotificationSize.md:
        return textTheme.xs?.medium;
      case DSBadgeNotificationSize.lg:
        return textTheme.sm?.semibold;
    }
  }

  BorderRadiusGeometry? get getBorderRadius => switch (this) {
        DSBadgeNotificationSize.xs =>
          DSRadiuses.radiusFull.borderRadiusGeometry,
        DSBadgeNotificationSize.md =>
          DSRadiuses.radiusFull.borderRadiusGeometry,
        DSBadgeNotificationSize.lg =>
          DSRadiuses.radiusFull.borderRadiusGeometry,
      };

  const DSBadgeNotificationSize({
    required this.padding,
    required this.borderWidth,
  });
}

class DSBadgeNotificationThemeExtension
    extends ThemeExtension<DSBadgeNotificationThemeExtension> {
  final DSTextTheme textTheme;

  DSBadgeNotificationThemeExtension({required this.textTheme});

  DSBadgeNotificationStateTheme get _dSPrimaryBadgeNotificationTheme {
    const colors = DSColors();
    return DSBadgeNotificationStateTheme(
      backgroundColor: colors.brand.shade500,
      textColor: colors.gray.white,
      borderColor: colors.gray.white,
    );
  }

  DSBadgeNotificationStateTheme get _dSSecondaryBadgeNotificationTheme {
    const colors = DSColors();
    return DSBadgeNotificationStateTheme(
      backgroundColor: DSColorUsages.icon.secondary,
      textColor: colors.gray.white,
      borderColor: colors.gray.white,
    );
  }

  DSBadgeNotificationStateTheme get _dSTertiaryBadgeNotificationTheme =>
      DSBadgeNotificationStateTheme(
        backgroundColor: DSColorUsages.background.primary,
        textColor: DSColorUsages.text.linkRed,
        borderColor: const DSColors().transparent,
      );

  DSBadgeNotificationStateTheme getDSPrimaryBadgeNotificationTheme(
    DSBadgeNotificationVariants variant,
  ) {
    switch (variant) {
      case DSBadgeNotificationVariants.primary:
        return _dSPrimaryBadgeNotificationTheme;
      case DSBadgeNotificationVariants.secondary:
        return _dSSecondaryBadgeNotificationTheme;
      case DSBadgeNotificationVariants.tertiary:
        return _dSTertiaryBadgeNotificationTheme;
    }
  }

  @override
  ThemeExtension<DSBadgeNotificationThemeExtension> copyWith({
    DSTextTheme? textTheme,
  }) {
    return DSBadgeNotificationThemeExtension(
      textTheme: textTheme ?? this.textTheme,
    );
  }

  @override
  ThemeExtension<DSBadgeNotificationThemeExtension> lerp(
    covariant DSBadgeNotificationThemeExtension? other,
    double t,
  ) {
    return DSBadgeNotificationThemeExtension(
      textTheme: textTheme.lerp(other?.textTheme, t),
    );
  }
}
