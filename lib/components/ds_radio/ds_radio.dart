import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import '../../theme/ds_theme.dart';

enum DSRadioSize {
  sm,
  md,
  lg,
}

enum DSRadioVariant {
  primary,
  secondary,
  outline,
  ghost,
}

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
  /// Radio<SingingCharacter>(
  ///   value: SingingCharacter.lafayette,
  ///   groupValue: _character,
  ///   onChanged: (SingingCharacter? newValue) {
  ///     setState(() {
  ///       _character = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<T?>? onChanged;

  /// The label text to display next to the radio button.
  final String? label;

  /// The description text to display below the label.
  final String? description;

  /// Whether the radio button is disabled.
  final bool isDisabled;

  /// The size of the radio button.
  final DSRadioSize size;

  /// The variant of the radio button.
  final DSRadioVariant variant;

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
    this.size = DSRadioSize.md,
    this.variant = DSRadioVariant.primary,
    this.labelOnRight = true,
    this.child,
  });

  @override
  State<DSRadio> createState() => _DSRadioState();
}

class _DSRadioState extends DSStateBase<DSRadio> {
  late DSRadioTheme componentTheme =
      theme.extension<DSRadioThemeExtension>()!.dSRadioTheme;

  bool get isSelected => widget.value == widget.groupValue;
  bool get isEnabled => !widget.isDisabled && widget.onChanged != null;

  double get _radioSize {
    switch (widget.size) {
      case DSRadioSize.sm:
        return 16.0;
      case DSRadioSize.md:
        return 20.0;
      case DSRadioSize.lg:
        return 24.0;
    }
  }

  double get _borderWidth {
    if (isSelected) {
      switch (widget.size) {
        case DSRadioSize.sm:
          return 4.0;
        case DSRadioSize.md:
          return 6.0;
        case DSRadioSize.lg:
          return 8.0;
      }
    }
    return 1.5;
  }

  Color _getBorderColor() {
    if (!isEnabled) {
      return DSColorUsages.border.tertiary;
    }

    if (isSelected) {
      switch (widget.variant) {
        case DSRadioVariant.primary:
          return colors.brand.primary;
        case DSRadioVariant.secondary:
          return colors.brand.tint400;
        case DSRadioVariant.outline:
          return colors.brand.primary;
        case DSRadioVariant.ghost:
          return colors.brand.primary;
      }
    }

    return DSColorUsages.border.primary;
  }

  Color _getBackgroundColor() {
    if (!isEnabled) {
      return DSColorUsages.background.disable;
    }

    switch (widget.variant) {
      case DSRadioVariant.primary:
        return isSelected ? colors.brand.primary : colors.white;
      case DSRadioVariant.secondary:
        return isSelected ? colors.brand.tint400 : colors.white;
      case DSRadioVariant.outline:
        return colors.white;
      case DSRadioVariant.ghost:
        return isSelected
            ? colors.brand.primary.withOpacity(0.1)
            : colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radioWidget = GestureDetector(
      onTap: isEnabled ? () => widget.onChanged!(widget.value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _radioSize,
        height: _radioSize,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          shape: BoxShape.circle,
          border: Border.all(
            color: _getBorderColor(),
            width: _borderWidth,
          ),
          boxShadow: widget.variant == DSRadioVariant.ghost && isSelected
              ? [
                  BoxShadow(
                    color: colors.brand.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: isSelected && widget.variant != DSRadioVariant.outline
            ? Center(
                child: Container(
                  width: _radioSize * 0.3,
                  height: _radioSize * 0.3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            : null,
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
      onTap: isEnabled ? () => widget.onChanged!(widget.value) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
