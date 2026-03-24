part of '../../ds_theme.dart';

/// Theme configuration for the DSTabs segmented control component.
///
/// Provides styling for the container and individual tab items including
/// colors, typography, spacing, and border radius.
class DSTabsTheme {
  /// Background color of the tab container.
  final Color backgroundColor;

  /// Background color when tab is selected.
  final Color selectedTabBackgroundColor;

  /// Background color when tab is unselected.
  final Color unselectedTabBackgroundColor;

  /// Text color when tab is selected.
  final DSColor selectedTextColor;

  /// Text color when tab is unselected.
  final DSColor unselectedTextColor;

  /// Badge background color when tab is selected.
  final Color selectedBadgeColor;

  /// Badge background color when tab is unselected.
  final Color unselectedBadgeColor;

  /// Badge text color.
  final Color badgeTextColor;

  /// Badge border color.
  final Color badgeBorderColor;

  /// Border radius of the container.
  final double containerBorderRadius;

  /// Border radius of each tab.
  final double tabBorderRadius;

  /// Padding inside the container.
  final EdgeInsetsGeometry containerPadding;

  /// Gap between tabs.
  final double tabGap;

  /// Height of each tab.
  final double tabHeight;

  /// Horizontal padding of each tab.
  final EdgeInsetsGeometry tabPadding;

  /// Spacing between label and badge.
  final double badgeSpacing;

  /// Text style for tab label.
  final DSTextStyle? labelStyle;

  /// Text style for badge count.
  final DSTextStyle? badgeStyle;

  const DSTabsTheme({
    required this.backgroundColor,
    required this.selectedTabBackgroundColor,
    required this.unselectedTabBackgroundColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.selectedBadgeColor,
    required this.unselectedBadgeColor,
    required this.badgeTextColor,
    required this.badgeBorderColor,
    this.containerBorderRadius = 14,
    this.tabBorderRadius = 12,
    this.containerPadding = const EdgeInsets.all(4),
    this.tabGap = 4,
    this.tabHeight = 36,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    this.badgeSpacing = 8,
    this.labelStyle,
    this.badgeStyle,
  });

  /// Creates default theme from design tokens.
  factory DSTabsTheme.fromContext(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    const dsColors = DSColors();

    return DSTabsTheme(
      backgroundColor: colors.gray.shade200,
      selectedTabBackgroundColor: colors.gray.shade50,
      unselectedTabBackgroundColor: colors.gray.shade200,
      selectedTextColor: DSColorUsages.text.primary,
      unselectedTextColor: DSColorUsages.text.tertiary,
      selectedBadgeColor: dsColors.brand.shade500,
      unselectedBadgeColor: colors.gray.shade400,
      badgeTextColor: colors.gray.shade50,
      badgeBorderColor: colors.gray.shade50,
      labelStyle: textTheme.base?.medium,
      badgeStyle: textTheme.xxs?.medium,
    );
  }
}
