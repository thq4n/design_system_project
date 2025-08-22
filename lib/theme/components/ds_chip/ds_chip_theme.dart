part of '../../ds_theme.dart';

enum DSChipStyles { whiteStyle, grayStyle, brandStyle }

enum DSChipStates { defaultState, selectedState, disableState }

class DSChipTheme {
  final DSColor backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final DSColor borderColor;
  final DSColor textColor;
  final DSColor iconColor;
  final DSBadgeNotificationVariants badgeVariant;
  final EdgeInsets padding;

  DSChipTheme({
    required this.backgroundColor,
    required this.borderColor,
    this.borderRadius = 1000,
    this.borderWidth = 1,
    required this.textColor,
    required this.iconColor,
    required this.badgeVariant,
    this.padding = const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
  });
}
