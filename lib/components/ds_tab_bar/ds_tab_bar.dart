import 'package:flutter/material.dart';

import '../../design_system_core/ds_color/ds_colors_core.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import '../../theme/ds_theme.dart';

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
///   tabs: [
///     Tab(text: 'Tab 1'),
///     Tab(text: 'Tab 2'),
///     Tab(text: 'Tab 3'),
///   ],
/// )
/// ```
class DSTabBar extends StatelessWidget {
  /// Creates a DSTabBar widget.
  ///
  /// [controller] - The TabController that controls the tab selection.
  /// [tabs] - The list of tabs to display.
  /// [isScrollable] - Whether the tabs should be scrollable.
  ///   If null, uses theme default.
  /// [backgroundColor] - The background color of the TabBar container.
  ///   If null, uses theme default.
  const DSTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = true,
    this.backgroundColor,
  });

  /// The TabController that controls the tab selection.
  final TabController controller;

  /// The list of tabs to display.
  final List<Tab> tabs;

  /// Whether the tabs should be scrollable.
  /// If null, uses theme default.
  final bool isScrollable;

  /// The background color of the TabBar container.
  /// If null, uses theme default.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final themeExtension =
        Theme.of(context).extension<DSTabBarThemeExtension>();
    final componentTheme =
        themeExtension?.getDSTabBarTheme() ?? _getDefaultTheme(context);

    const dsColors = DSColors();

    return Container(
      color: backgroundColor ?? componentTheme.backgroundColor,
      child: TabBar(
        isScrollable: isScrollable,
        labelStyle: componentTheme.labelStyle,
        unselectedLabelStyle: componentTheme.unselectedLabelStyle,
        tabs: tabs,
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
    );
  }
}
