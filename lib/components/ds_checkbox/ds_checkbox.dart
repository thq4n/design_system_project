import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../theme/ds_theme.dart';

class DSCheckbox extends StatefulWidget {
  final bool initialValue;
  final void Function(bool) onChanged;
  final DSCheckboxVariants variant;
  const DSCheckbox(
      {super.key,
      this.variant = DSCheckboxVariants.primary,
      this.initialValue = false,
      required this.onChanged});

  @override
  State<DSCheckbox> createState() => _DSCheckboxState();
}

class _DSCheckboxState extends DSStateBase<DSCheckbox> {
  late DSCheckboxTheme componentTheme =
      theme.extension<DSCheckboxThemeExtension>()!.dSCheckboxTheme;

  late final _isCheckedNotifier = ValueNotifier<bool>(widget.initialValue);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isCheckedNotifier,
      builder: (context, isChecked, child) {
        return Checkbox(
          side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(
              color: isChecked
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
          value: isChecked,
          onChanged: (value) {
            if (value == null) {
              return;
            }
            _isCheckedNotifier.value = value;
            widget.onChanged(value);
          },
        );
      },
    );
  }
}
