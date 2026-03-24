import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../constants/constants.dart';
import '../../theme/ds_theme.dart';

class DSCheckbox extends StatefulWidget {
  final bool isChecked;
  final void Function(bool) onChanged;
  final DSCheckboxVariants variant;
  final double? size;

  const DSCheckbox({
    super.key,
    this.variant = DSCheckboxVariants.primary,
    this.isChecked = false,
    required this.onChanged,
    this.size,
  });

  @override
  State<DSCheckbox> createState() => _DSCheckboxState();
}

class _DSCheckboxState extends DSStateBase<DSCheckbox> {
  late DSCheckboxTheme componentTheme =
      theme.extension<DSCheckboxThemeExtension>()!.dSCheckboxTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size ?? DSIconSizes.size20,
      height: widget.size ?? DSIconSizes.size20,
      child: Checkbox(
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(
            color: widget.isChecked
                ? componentTheme.activeBorderColor
                : componentTheme.inactiveBorderColor,
            width: componentTheme.borderWidth,
          ),
        ),
        visualDensity: VisualDensity.compact,
        activeColor: componentTheme.activeColor,
        checkColor: componentTheme.checkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(componentTheme.borderRadius),
        ),
        fillColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.selected)
              ? componentTheme.activeColor
              : componentTheme.inactiveColor,
        ),
        value: widget.isChecked,
        onChanged: (value) {
          if (value == null) {
            return;
          }
          widget.onChanged(value);
        },
      ),
    );
  }
}
