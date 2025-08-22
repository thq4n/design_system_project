// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../../design_system_project.dart';

/// A configuration class for the badge notification component.
///
/// This class is used to configure the badge notification component.
class DSBadgeNotificationConfig {
  DSBadgeNotificationConfig._();

  /// The maximum value to display on the badge notification.
  /// If the label is greater than the maxValue, the badge will display the maxValue +
  /// If not provided, the default value is [DSBadgeNotificationConfig.maxValue].
  static const int maxValue = 99;
}

/// A badge notification component that displays a small notification count.
///
/// This component is used to indicate the number of unread messages or notifications.
class DSBadgeNotification extends StatelessWidget {
  /// The visual variant/style of the button (primary, secondary, ghost etc)
  final DSBadgeNotificationVariants variant;

  /// The size preset of the button (small, medium, large)
  final DSBadgeNotificationSize size;

  /// The text label displayed on the button
  final int? count;

  /// The maximum value to display on the badge notification.
  /// If the label is greater than the maxValue, the badge will display the maxValue +
  /// If not provided, the default value is [DSBadgeNotificationConfig.maxValue].
  final int? maxValue;

  /// Creates a badge notification component.
  const DSBadgeNotification({
    super.key,
    this.variant = DSBadgeNotificationVariants.primary,
    this.size = DSBadgeNotificationSize.md,
    this.count,
    this.maxValue = DSBadgeNotificationConfig.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    final DSBadgeNotificationStateTheme componentTheme = Theme.of(context)
        .extension<DSBadgeNotificationThemeExtension>()!
        .getDSPrimaryBadgeNotificationTheme(
          variant,
        );

    final backgroundColor = componentTheme.backgroundColor;

    if (count == null || count == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: size.padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: DSRadiuses.radiusFull.borderRadiusGeometry,
        border: Border.all(color: context.colors.gray.white, width: 1),
      ),
      child: Text(
        _getDisplayLabel(),
        style: size
            .getTextStyle(context)
            ?.copyWithColor(componentTheme.textColor)
            .copyWith(height: 0),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _getDisplayLabel() {
    String displayLabel = '';
    if (count != null) {
      if (count != null && maxValue != null && count! > maxValue!) {
        displayLabel = '$maxValue+';
      } else {
        displayLabel = count!.toString();
      }
    }

    return displayLabel;
  }
}
