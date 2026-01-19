import 'package:flutter/material.dart';

import '../../design_system_core/ds_color/ds_colors_core.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import '../../theme/ds_theme.dart';
import '../ds_badge_notification/ds_badge_notification.dart';

/// A custom TabBar widget following the design system standards.
///
/// This widget provides a styled TabBar with consistent design system colors,
/// typography, and indicators. It includes a gradient indicator and custom
/// styling for selected and unselected tabs.
///
/// The widget uses theme configuration from DSTabBarThemeExtension to ensure
/// consistent styling across the application.
///
/// Example usage:
/// ```dart
/// DSTabBar(
///   controller: _tabController,
///   tabs: ['Tab 1', 'Tab 2', 'Tab 3'],
/// )
/// ```
class DSTabBar extends StatelessWidget {
  /// Creates a DSTabBar widget.
  ///
  /// [controller] - The TabController that controls the tab selection.
  /// [tabs] - The list of tab labels as strings.
  /// [isScrollable] - Whether the tabs should be scrollable.
  ///   If null, uses theme default.
  /// [backgroundColor] - The background color of the TabBar container.
  ///   If null, uses theme default.
  /// [getBadgeCount] - Optional callback to get badge count for each tab.
  ///   Receives the tab index and returns the badge count.
  const DSTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = true,
    this.backgroundColor,
    this.getBadgeCount,
  });

  /// The TabController that controls the tab selection.
  final TabController controller;

  /// The list of tab labels as strings.
  final List<String> tabs;

  /// Whether the tabs should be scrollable.
  /// If null, uses theme default.
  final bool isScrollable;

  /// The background color of the TabBar container.
  /// If null, uses theme default.
  final Color? backgroundColor;

  /// Optional callback to get badge count for each tab.
  /// Receives the tab index and returns the badge count.
  final int Function(int)? getBadgeCount;

  @override
  Widget build(BuildContext context) {
    final themeExtension =
        Theme.of(context).extension<DSTabBarThemeExtension>();
    final componentTheme =
        themeExtension?.getDSTabBarTheme() ?? _getDefaultTheme(context);

    const dsColors = DSColors();

    // Build tabs from string list
    final builtTabs = tabs.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;
      final badgeCount = getBadgeCount?.call(index);

      if (badgeCount != null && badgeCount > 0) {
        return Tab(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final isSelected = controller.index == index;
              final textStyle = isSelected
                  ? componentTheme.labelStyle
                  : componentTheme.unselectedLabelStyle;

              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: textStyle,
                  ),
                  SizedBox(width: componentTheme.badgeSpacing),
                  DSBadgeNotification(
                    count: badgeCount,
                    size: DSBadgeNotificationSize.md,
                    variant: isSelected
                        ? DSBadgeNotificationVariants.primary
                        : DSBadgeNotificationVariants.secondary,
                  ),
                ],
              );
            },
          ),
        );
      }

      return Tab(text: label);
    }).toList();

    return Container(
      color: backgroundColor ?? componentTheme.backgroundColor,
      child: TabBar(
        isScrollable: isScrollable,
        labelStyle: componentTheme.labelStyle,
        unselectedLabelStyle: componentTheme.unselectedLabelStyle,
        tabs: builtTabs,
        tabAlignment: isScrollable == true ? componentTheme.tabAlignment : null,
        indicatorSize: componentTheme.indicatorSize,
        indicator: BoxDecoration(
          gradient: dsColors.brand.createGradient(
            colors: componentTheme.indicatorGradientColors,
            stops: componentTheme.indicatorGradientStops,
            begin: componentTheme.indicatorGradientBegin,
            end: componentTheme.indicatorGradientEnd,
          ),
          border: Border(
            bottom: BorderSide(
              color: componentTheme.indicatorBorderColor,
              width: componentTheme.indicatorBorderWidth,
            ),
          ),
        ),
        controller: controller,
      ),
    );
  }

  /// Gets default theme when theme extension is not available.
  DSTabBarTheme _getDefaultTheme(BuildContext context) {
    final textTheme = context.textTheme;
    const dsColors = DSColors();

    return DSTabBarTheme(
      backgroundColor: DSColorUsages.background.primary,
      labelStyle:
          textTheme.base?.semibold.copyWithColor(DSColorUsages.text.linkRed),
      unselectedLabelStyle:
          textTheme.base?.regular.copyWithColor(DSColorUsages.text.tertiary),
      indicatorGradientColors: [
        dsColors.brand
            .custom(0xFFFF3F3F)
            .withOpacity(0.3), // #FEE4E2 equivalent
        dsColors.brand.white.withOpacity(0), // #FFFFFF
      ],
      indicatorGradientStops: const [0.1869, 0.8836], // 18.69% and 88.36%
      indicatorGradientBegin: Alignment.bottomCenter,
      indicatorGradientEnd: Alignment.topCenter,
      indicatorBorderColor: dsColors.brand.shade600,
      indicatorBorderWidth: 2,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.tab,
      badgeSpacing: 8,
    );
  }
}
