import 'package:flutter/material.dart';

import '../../design_system_project.dart';

class DSChip extends StatelessWidget {
  final String label;
  final dynamic prefix;
  final dynamic suffix;
  final int? badgeNumber;
  final DSChipStyles? style;
  final DSChipStates? state;
  final VoidCallback? onTap;

  const DSChip({
    super.key,
    required this.label,
    this.prefix,
    this.suffix,
    this.badgeNumber,
    this.style,
    this.state,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final DSChipTheme _componentTheme =
        Theme.of(context).extension<DSChipThemeExtension>()!.getDSChipTheme(
              style ?? DSChipStyles.whiteStyle,
              state ?? DSChipStates.defaultState,
            );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: _componentTheme.padding,
        decoration: BoxDecoration(
          color: _componentTheme.backgroundColor,
          border: Border.all(
            color: _componentTheme.borderColor,
            width: _componentTheme.borderWidth,
          ),
          borderRadius: BorderRadius.circular(_componentTheme.borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefix != null)
              _buildPrefixWidget(prefix, _componentTheme.iconColor),
            _buildLabel(_componentTheme.textColor),
            if (badgeNumber != null && badgeNumber! > 0)
              _buildBadge(_componentTheme.badgeVariant),
            if (suffix != null) _buildSuffix(_componentTheme.iconColor),
          ],
        ),
      ),
    );
  }

  Widget _buildPrefixWidget(dynamic prefix, DSColor iconColor) {
    Widget widget;
    if (prefix is Widget) {
      widget = prefix;
    } else if (prefix is String) {
      widget = DSImageView(
        source: prefix,
        width: DSIconSizes.size16,
        height: DSIconSizes.size16,
        color: iconColor,
      );
    } else {
      widget = const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: widget,
    );
  }

  Widget _buildLabel(DSColor textColor) {
    return Builder(
      builder: (context) => Text(
        label,
        style: context.textTheme.sm?.medium.copyWithColor(textColor),
      ),
    );
  }

  Widget _buildBadge(DSBadgeNotificationVariants badgeVariant) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: DSBadgeNotification(
        size: DSBadgeNotificationSize.md,
        count: badgeNumber,
        variant: badgeVariant,
      ),
    );
  }

  Widget _buildSuffix(DSColor iconColor) {
    Widget widget;
    if (suffix is Widget) {
      widget = suffix;
    } else if (suffix is String) {
      widget = DSImageView(
        source: suffix,
        width: DSIconSizes.size16,
        height: DSIconSizes.size16,
        color: iconColor,
      );
    } else {
      widget = const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: widget,
    );
  }
}
