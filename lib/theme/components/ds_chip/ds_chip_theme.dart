part of '../../ds_theme.dart';

enum DSChipStyles { whiteStyle, grayStyle, brandStyle }

enum DSChipStates { defaultState, selectedState, disableState }

class DSChipTheme {
  final DSColor backgroundColor;
  final DSColor borderColor;
  final DSColor textColor;
  final DSColor iconColor;
  final DSBadgeNotificationVariants badgeVariants;

  DSChipTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    required this.badgeVariants,
  });
}
