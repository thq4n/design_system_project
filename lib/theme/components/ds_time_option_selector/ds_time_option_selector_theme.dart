part of '../../ds_theme.dart';

class DSTimeOptionSelectorTheme {
  const DSTimeOptionSelectorTheme({
    required this.titleColor,
    required this.requiredIndicatorColor,
    required this.textStyle,
    required this.selectedBackgroundColor,
    required this.unselectedBackgroundColor,
    required this.selectedBorderColor,
    required this.unselectedBorderColor,
    required this.iconColor,
    required this.borderRadius,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 8,
    this.tilePadding = const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    this.iconLabelSpacing = 4,
    this.selectionAnimationDuration = const Duration(milliseconds: 200),
    this.selectionAnimationCurve = Curves.easeInOut,
  });

  final DSColor titleColor;
  final DSColor requiredIndicatorColor;
  final DSTextStyle? textStyle;
  final DSColor selectedBackgroundColor;
  final DSColor unselectedBackgroundColor;
  final DSColor selectedBorderColor;
  final DSColor unselectedBorderColor;
  final DSColor iconColor;
  final DSRadius borderRadius;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry tilePadding;
  final double iconLabelSpacing;
  final Duration selectionAnimationDuration;
  final Curve selectionAnimationCurve;

  factory DSTimeOptionSelectorTheme.fromContext(BuildContext context) {
    return DSTimeOptionSelectorTheme(
      titleColor: DSColorUsages.text.primary,
      requiredIndicatorColor: DSColorUsages.text.error,
      textStyle: context.textTheme.sm?.medium,
      selectedBackgroundColor: DSColorUsages.background.brandSecondary,
      unselectedBackgroundColor: DSColorUsages.background.primary,
      selectedBorderColor: DSColorUsages.border.brand,
      unselectedBorderColor: DSColorUsages.border.primary,
      iconColor: DSColorUsages.icon.primary,
      borderRadius: DSRadiuses.radiusMd,
    );
  }
}
