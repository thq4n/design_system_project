part of '../../ds_theme.dart';

/// Theme configuration for the DSTabBar component.
///
/// Provides styling configuration for the TabBar including colors,
/// typography, and indicator styling.
class DSTabBarTheme {
  /// Background color of the TabBar container.
  final Color? backgroundColor;

  /// Text style for selected/labeled tabs.
  final DSTextStyle? labelStyle;

  /// Text style for unselected tabs.
  final DSTextStyle? unselectedLabelStyle;

  /// Gradient colors for the indicator.
  final List<Color> indicatorGradientColors;

  /// Gradient stops for the indicator.
  final List<double> indicatorGradientStops;

  /// Alignment for gradient begin.
  final Alignment indicatorGradientBegin;

  /// Alignment for gradient end.
  final Alignment indicatorGradientEnd;

  /// Border color for the indicator.
  final DSColor indicatorBorderColor;

  /// Border width for the indicator.
  final double indicatorBorderWidth;

  /// Whether tabs should be scrollable.
  final bool isScrollable;

  /// Tab alignment.
  final TabAlignment tabAlignment;

  /// Indicator size.
  final TabBarIndicatorSize indicatorSize;

  /// Spacing between tab label and badge.
  final double badgeSpacing;

  const DSTabBarTheme({
    this.backgroundColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    required this.indicatorGradientColors,
    required this.indicatorGradientStops,
    required this.indicatorGradientBegin,
    required this.indicatorGradientEnd,
    required this.indicatorBorderColor,
    this.indicatorBorderWidth = 2,
    this.isScrollable = true,
    this.tabAlignment = TabAlignment.start,
    this.indicatorSize = TabBarIndicatorSize.tab,
    this.badgeSpacing = 8,
  });
}
