part of '../../ds_theme.dart';

enum DSBadgeNotificationVariants {
  primary,
  secondary,
  tertiary,
}

enum DSBadgeNotificationSize {
  lg(borderRadius: 16, borderWidth: 1),

  md(
    borderRadius: 12,
    borderWidth: 1,
  ),
  xs(
    borderRadius: 8,
    borderWidth: 1,
  );

  final double borderRadius;
  final double borderWidth;

  DSTextStyle? textStyle(BuildContext context) {
    final textTheme = context.textTheme;
    switch (this) {
      case DSBadgeNotificationSize.lg:
        return textTheme.xxs?.semibold;
      case DSBadgeNotificationSize.md:
        return textTheme.xs?.semibold;
      case DSBadgeNotificationSize.xs:
        return textTheme.sm?.semibold;
    }
  }

  const DSBadgeNotificationSize({
    required this.borderRadius,
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
      borderColor: colors.gray.white,
      backgroundColor: colors.brand.shade500,
      textColor: colors.gray.white,
    );
  }

  DSBadgeNotificationStateTheme get _dSSecondaryBadgeNotificationTheme {
    const colors = DSColors();
    return DSBadgeNotificationStateTheme(
      borderColor: colors.gray.white,
      backgroundColor: DSColorUsages.icon.secondary,
      textColor: colors.gray.white,
    );
  }

  DSBadgeNotificationStateTheme get _dSTertiaryBadgeNotificationTheme =>
      DSBadgeNotificationStateTheme(
        borderColor: DSColorUsages.background.brandPrimary,
        backgroundColor: DSColorUsages.background.primary,
        textColor: DSColorUsages.text.linkRed,
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
