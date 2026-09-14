import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import '../../theme/ds_theme.dart';
import 'ds_checkbox.dart';

/// A tappable row that pairs a [DSCheckbox] with a title (and optional
/// description), matching the labeled layout pattern used by [DSRadio].
class DSCheckboxTile extends StatefulWidget {
  final bool isChecked;
  final void Function(bool) onChanged;
  final String title;
  final String? description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final DSCheckboxVariants variant;
  final double? checkboxSize;
  final bool isDisabled;
  final CrossAxisAlignment crossAxisAlignment;

  const DSCheckboxTile({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.title,
    this.description,
    this.titleStyle,
    this.descriptionStyle,
    this.variant = DSCheckboxVariants.primary,
    this.checkboxSize,
    this.isDisabled = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  State<DSCheckboxTile> createState() => _DSCheckboxTileState();
}

class _DSCheckboxTileState extends DSStateBase<DSCheckboxTile> {
  late DSCheckboxTheme componentTheme =
      theme.extension<DSCheckboxThemeExtension>()!.dSCheckboxTheme;

  bool get _isEnabled => !widget.isDisabled;

  void _toggle() {
    if (!_isEnabled) {
      return;
    }
    widget.onChanged(!widget.isChecked);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        widget.titleStyle ??
        textTheme.base?.regular.copyWithColor(
          _isEnabled
              ? DSColorUsages.text.primary
              : DSColorUsages.text.disable,
        );

    final descriptionStyle =
        widget.descriptionStyle ??
        textTheme.sm?.regular.copyWithColor(
          _isEnabled
              ? DSColorUsages.text.secondary
              : DSColorUsages.text.disable,
        );

    return GestureDetector(
      onTap: _isEnabled ? _toggle : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          IgnorePointer(
            child: DSCheckbox(
              isChecked: widget.isChecked,
              variant: widget.variant,
              size: widget.checkboxSize,
              onChanged: (_) {},
            ),
          ),
          SizedBox(width: componentTheme.labelSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title, style: titleStyle),
                if (widget.description != null) ...[
                  const SizedBox(height: 4),
                  Text(widget.description!, style: descriptionStyle),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
