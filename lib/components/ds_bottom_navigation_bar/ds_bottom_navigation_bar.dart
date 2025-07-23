import 'package:flutter/material.dart';

import '../../design_system_project.dart';

/// AppBottomNavigationBar with floating button support
///
/// This widget requires an odd number of items to properly layout the floating
/// button in the center. The assertion will throw an error if an even number of
/// items is provided.
///
/// Example usage:
/// ```dart
/// AppBottomNavigationBar(
///   items: [
///     AppBottomNavigationBarItemData(
///       title: 'Home',
///       inactiveIcon: 'home_outline',
///       activeIcon: 'home_bold',
///     ),
///     AppBottomNavigationBarItemData(
///       title: 'Profile',
///       inactiveIcon: 'profile_outline',
///       activeIcon: 'profile_bold',
///     ),
///     AppBottomNavigationBarItemData(
///       title: 'Settings',
///       inactiveIcon: 'settings_outline',
///       activeIcon: 'settings_bold',
///     ),
///   ], // 3 items (odd number) - ✅ Valid
///   floatingButtonIconTitle: 'Scan QR',
/// )
///
/// // This would throw an assertion error:
/// // items: [item1, item2] // 2 items (even number) - ❌ Invalid
/// ```

class AppBottomNavigationBarItemData {
  final String title;
  final String inactiveIcon;
  final String activeIcon;
  final TextStyle? inactiveTextStyle;
  final TextStyle? activeTextStyle;
  final Color? inactiveIconColor;
  final Color? activeIconColor;

  AppBottomNavigationBarItemData({
    required this.title,
    required this.inactiveIcon,
    required this.activeIcon,
    this.inactiveTextStyle,
    this.activeTextStyle,
    this.inactiveIconColor,
    this.activeIconColor,
  });
}

class AppBottomNavigationBar extends StatefulWidget {
  final List<AppBottomNavigationBarItemData> items;
  final String? floatingButtonIconTitle;
  final TextStyle? floatingButtonIconTitleStyle;
  final void Function(int) onPageChanged;

  const AppBottomNavigationBar({
    super.key,
    required this.items,
    this.floatingButtonIconTitle,
    this.floatingButtonIconTitleStyle,
    required this.onPageChanged,
  });

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late final textTheme = context.textTheme;
  final currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    // Assert that items list has odd number of elements for proper layout with
    // floating button
    assert(
      widget.items.length.isOdd,
      'AppBottomNavigationBar requires an odd number of items for proper '
      'layout with floating button. Current count: ${widget.items.length}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      key: UniqueKey(),
      padding: EdgeInsets.zero,
      //bottom navigation bar on scaffold
      elevation: 20,
      color: DSColorUsages.background.primary,
      shape: const CircularNotchedRectangle(), //shape of notch
      height: 56, //notch margin between floating button and bottom appbar
      child: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, groupType, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _buildNavigationItems(),
          );
        },
      ),
    );
  }

  List<Widget> _buildNavigationItems() {
    final items = <Widget>[];
    final middleIndex = widget.items.length ~/ 2;

    // Add items before the middle (floating button position)
    for (int i = 0; i < middleIndex; i++) {
      items.add(
        Expanded(
          child: AppBottomNavigationBarItem(
            itemData: widget.items[i],
            itemIndex: i,
            groupIndex: currentIndex.value,
            onTap: _onTap,
          ),
        ),
      );
    }

    // Add floating button placeholder
    items.add(
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.floatingButtonIconTitle ?? '',
              style:
                  (widget.floatingButtonIconTitleStyle ?? textTheme.xs?.medium)
                      ?.copyWith(
                color: DSColorUsages.text.tertiary,
              ),
            ),
          ],
        ),
      ),
    );

    // Add items after the middle
    for (int i = middleIndex; i < widget.items.length; i++) {
      items.add(
        Expanded(
          child: AppBottomNavigationBarItem(
            itemData: widget.items[i],
            itemIndex: i,
            groupIndex: currentIndex.value,
            onTap: _onTap,
          ),
        ),
      );
    }

    return items;
  }

  void _onTap(int index) {
    widget.onPageChanged(index);
    currentIndex.value = index;
  }
}

class AppBottomNavigationBarItem<T> extends StatelessWidget {
  const AppBottomNavigationBarItem({
    super.key,
    required this.itemData,
    required this.itemIndex,
    required this.groupIndex,
    required this.onTap,
  });

  final AppBottomNavigationBarItemData itemData;
  final int itemIndex;
  final int groupIndex;
  final Function(int) onTap;

  bool get isSelected => itemIndex == groupIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final TextStyle? textStyle =
        (isSelected ? itemData.activeTextStyle : itemData.inactiveTextStyle) ??
            textTheme.xs?.medium.copyWith(
              color: isSelected
                  ? DSColorUsages.text.linkRed
                  : DSColorUsages.text.tertiary,
            );

    final Color? iconColor = (isSelected
            ? itemData.activeIconColor
            : itemData.inactiveIconColor) ??
        (isSelected ? DSColorUsages.icon.brand : DSColorUsages.icon.tertiary);

    return TransparentInkWell(
      onTap: () => onTap(itemIndex),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isSelected ? 2 : 0,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: isSelected
                ? BoxDecoration(
                    color: DSColorUsages.background.brandPrimary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  )
                : null,
          ),
          SizedBox(
            height: 24,
            width: 24,
            child: DSImageView(
              source: isSelected ? itemData.activeIcon : itemData.inactiveIcon,
              width: DSIconSizes.size24,
              height: DSIconSizes.size24,
              color: iconColor,
            ),
          ),
          Text(
            itemData.title,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
