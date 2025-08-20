// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../theme/ds_theme.dart';

/// A badge notification component that displays a small notification count.
///
/// This component is used to indicate the number of unread messages or notifications.
class DSBadgeNotification extends StatefulWidget {
  final DSBadgeNotificationVariants variant;

  /// The size preset of the button (small, medium, large)
  final DSBadgeNotificationSize size;

  /// The text label displayed on the button
  final String? label;
  final num? maxValue;

  /// The visual variant/style of the button (primary, secondary, ghost etc)

  /// Creates a badge notification component.
  const DSBadgeNotification(
      {super.key,
      this.variant = DSBadgeNotificationVariants.primary,
      this.size = DSBadgeNotificationSize.md,
      this.label,
      this.maxValue});

  @override
  State<DSBadgeNotification> createState() => _DSBadgeNotificationState();
}

class _DSBadgeNotificationState extends DSStateBase<DSBadgeNotification> {
  @override
  Widget build(BuildContext context) {
    final DSBadgeNotificationStateTheme componentTheme = theme
        .extension<DSBadgeNotificationThemeExtension>()!
        .getDSPrimaryBadgeNotificationTheme(
          widget.variant,
        );
    final backgroundColor = componentTheme.backgroundColor;
    final borderColor = componentTheme.borderColor;
    String displayLabel = '';
    if (widget.label != null) {
      final int? value = int.tryParse(widget.label!);
      if (value != null &&
          widget.maxValue != null &&
          value > widget.maxValue!) {
        displayLabel = "${widget.maxValue}+";
      } else {
        displayLabel = widget.label!;
      }
    }

//     final value = if(label && value && label > maxValue) {
// return `${maxvalue}+`
//     }else{
//       return `${label}`
//     };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(widget.size.borderRadius),
        border: Border.all(color: borderColor, width: widget.size.borderWidth),
      ),
      child: Text(
        displayLabel,
        style: widget.size
            .textStyle(context)
            ?.copyWithColor(componentTheme.textColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
