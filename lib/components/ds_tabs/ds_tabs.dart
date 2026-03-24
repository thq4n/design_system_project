import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../design_system_core/ds_color/ds_colors_core.dart';
import '../../extensions/extensions.dart';
import '../../theme/ds_theme.dart';

/// Một tab item trong [DSTabs].
class DSTabItem {
  const DSTabItem({
    required this.label,
    this.count = 0,
  });

  final String label;
  final int count;
}

/// Segmented tab control theo design system.
///
/// Hiển thị các tab dạng segmented với badge số lượng.
/// Dùng với [TabController] và [TabBarView].
///
/// Example:
/// ```dart
/// DSTabs(
///   controller: _tabController,
///   tabs: [
///     DSTabItem(label: 'Đơn thành công', count: 5),
///     DSTabItem(label: 'Lỗi', count: 2),
///   ],
/// )
/// ```
class DSTabs extends StatelessWidget {
  const DSTabs({
    super.key,
    required this.controller,
    required this.tabs,
    this.variant = DSTabsVariants.primary,
  });

  final TabController controller;
  final List<DSTabItem> tabs;
  final DSTabsVariants variant;

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<DSTabsThemeExtension>();
    final componentTheme = themeExtension != null
        ? themeExtension.getDSTabsTheme(context)
        : DSTabsTheme.fromContext(context);

    return Container(
      padding: componentTheme.containerPadding,
      decoration: BoxDecoration(
        color: componentTheme.backgroundColor,
        borderRadius: BorderRadius.circular(
          componentTheme.containerBorderRadius,
        ),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++) ...[
            if (i > 0) SizedBox(width: componentTheme.tabGap),
            Expanded(
              child: _DSTabItemWidget(
                item: tabs[i],
                index: i,
                controller: controller,
                theme: componentTheme,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DSTabItemWidget extends StatelessWidget {
  const _DSTabItemWidget({
    required this.item,
    required this.index,
    required this.controller,
    required this.theme,
  });

  final DSTabItem item;
  final int index;
  final TabController controller;
  final DSTabsTheme theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final isSelected = controller.index == index;
        final baseStyle = theme.labelStyle ?? context.textTheme.base?.medium;
        final labelStyle = baseStyle?.copyWithColor(
          isSelected ? theme.selectedTextColor : theme.unselectedTextColor,
        );
        final badgeColor =
            isSelected ? theme.selectedBadgeColor : theme.unselectedBadgeColor;

        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            if (controller.index != index) {
              controller.animateTo(index);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: theme.tabHeight,
            padding: theme.tabPadding,
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.selectedTabBackgroundColor
                  : theme.unselectedTabBackgroundColor,
              borderRadius: BorderRadius.circular(theme.tabBorderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.label,
                  style: labelStyle,
                ),
                if (item.count > 0) ...[
                  SizedBox(width: theme.badgeSpacing),
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.badgeBorderColor,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        item.count > 99 ? '99+' : '${item.count}',
                        style:
                            (theme.badgeStyle ?? context.textTheme.xxs?.medium)
                                ?.copyWithColor(
                                  DSColor.fromColor(theme.badgeTextColor),
                                )
                                .copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
