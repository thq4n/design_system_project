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
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: _componentTheme.backgroundColor,
          border: Border.all(color: _componentTheme.borderColor),
          borderRadius: DSRadiuses.radiusFull.borderRadiusGeometry,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefix != null) ...[
              prefix is Widget
                  ? prefix
                  : prefix is String
                      ? DSImageView(
                          source: prefix,
                          width: DSIconSizes.size16,
                          height: DSIconSizes.size16,
                          color: _componentTheme.iconColor,
                        )
                      : const SizedBox.shrink(),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: context.textTheme.sm?.medium.copyWithColor(
                _componentTheme.textColor,
              ),
            ),
            if (badgeNumber != null && badgeNumber! > 0) ...[
              const SizedBox(width: 4),
              DSBadgeNotification(
                size: DSBadgeNotificationSize.md,
                count: badgeNumber,
                variant: _componentTheme.badgeVariants,
              ),
            ],
            if (suffix != null) ...[
              const SizedBox(width: 8),
              suffix is Widget
                  ? suffix
                  : suffix is String
                      ? DSImageView(
                          source: suffix,
                          width: DSIconSizes.size16,
                          height: DSIconSizes.size16,
                          color: _componentTheme.iconColor,
                        )
                      : const SizedBox.shrink(),
            ],
          ],
        ),
      ),
    );
  }
}
