import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../constants/constants.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../theme/ds_theme.dart';

class DSRadio<T> extends StatefulWidget {
  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons.
  ///
  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T? groupValue;

  /// Called when the user selects this radio button.
  ///
  /// The radio button passes [value] as a parameter to this callback. The radio
  /// button does not actually change state until the parent widget rebuilds the
  /// radio button with the new [groupValue].
  ///
  /// If null, the radio button will be displayed as disabled.
  ///
  /// The provided callback will not be invoked if this radio button is already
  /// selected.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// DSRadio<String>(
  ///   value: 'option1',
  ///   groupValue: _selectedValue,
  ///   onChanged: (String? newValue) {
  ///     setState(() {
  ///       _selectedValue = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final void Function(T?) onChanged;

  /// The label text to display next to the radio button.
  final String? label;

  /// The description text to display below the label.
  final String? description;

  /// Whether the radio button is disabled.
  final bool isDisabled;

  /// Whether to show the label on the right side of the radio button.
  final bool labelOnRight;

  /// Custom widget to display as the radio button content.
  final Widget? child;

  const DSRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.description,
    this.isDisabled = false,
    this.labelOnRight = true,
    this.child,
  });

  @override
  State<DSRadio<T>> createState() => _DSRadioState<T>();
}

class _DSRadioState<T> extends DSStateBase<DSRadio<T>> {
  late DSRadioTheme componentTheme =
      theme.extension<DSRadioThemeExtension>()!.dSRadioTheme;

  bool get isSelected => widget.value == widget.groupValue;
  bool get isEnabled => !widget.isDisabled;

  double get _radioSize => DSIconSizes.size24;

  double get _radioInnerSize => 18;

  double get _borderWidth => isSelected ? 4 : 1;

  Gradient _getBorderColor() {
    if (!isEnabled) {
      return LinearGradient(
        colors: [
          DSColorUsages.border.secondary,
          DSColorUsages.border.secondary,
        ],
      );
    }

    if (isSelected) {
      return const LinearGradient(
        colors: [
          Color(0xFFFF3F3F),
          Color(0xFFD02727),
        ],
      );
    }

    return LinearGradient(
      colors: [
        DSColorUsages.border.secondary,
        DSColorUsages.border.secondary,
      ],
    );
  }

  Color _getBackgroundColor() {
    return DSColorUsages.background.primary;
  }

  @override
  Widget build(BuildContext context) {
    void _handleTap() {
      if (isEnabled) {
        widget.onChanged(widget.value);
      }
    }

    final radioWidget = GestureDetector(
      onTap: isEnabled ? _handleTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _radioInnerSize,
        height: _radioInnerSize,
        margin: EdgeInsets.all((_radioSize - _radioInnerSize) / 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: _getBorderColor(),
        ),
        child: Container(
          margin: EdgeInsets.all(_borderWidth),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );

    // If no label or child, return just the radio
    if (widget.label == null && widget.child == null) {
      return radioWidget;
    }

    // Build content (label + description or custom child)
    Widget content;
    if (widget.child != null) {
      content = widget.child!;
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null)
            Text(
              widget.label!,
              style: textTheme.bodyMedium?.copyWith(
                color: isEnabled
                    ? DSColorUsages.text.primary
                    : DSColorUsages.text.disable,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          if (widget.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.description!,
                style: textTheme.bodySmall?.copyWith(
                  color: isEnabled
                      ? DSColorUsages.text.secondary
                      : DSColorUsages.text.disable,
                ),
              ),
            ),
        ],
      );
    }

    // Arrange radio and content
    final children = widget.labelOnRight
        ? [radioWidget, const SizedBox(width: 12), Expanded(child: content)]
        : [Expanded(child: content), const SizedBox(width: 12), radioWidget];

    return GestureDetector(
      onTap: isEnabled ? _handleTap : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
