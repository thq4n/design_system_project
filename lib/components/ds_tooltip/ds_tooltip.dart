import 'package:flutter/material.dart';

import '../../design_system_project.dart';

class DSTooltip extends StatefulWidget {
  final String label;
  final DSColor? backgroundColor;
  final DSColor? textColor;
  final double? verticalOffset;
  final int? waitDuration;
  final int? showDuration;
  final Widget child;
  const DSTooltip(
      {super.key,
      required this.label,
      this.backgroundColor,
      this.textColor,
      this.verticalOffset,
      this.waitDuration,
      this.showDuration,
      required this.child});

  @override
  State<DSTooltip> createState() => _DSTooltipState();
}

class _DSTooltipState extends DSStateBase<DSTooltip> {
  late final DSTooltipTheme _componentTheme =
      Theme.of(context).extension<DSTooltipThemeExtension>()!.tooltipTheme;

  DSColor? get _backgroundColor {
    return widget.backgroundColor?.black;
  }

  DSColor? get _textColor {
    return widget.textColor?.white;
  }

  double? get _verticalOffset {
    return widget.verticalOffset;
  }

  int get _waitDuration {
    return widget.waitDuration ?? 400;
  }

  int get _showDuration {
    return widget.showDuration ?? 3;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      textStyle: textTheme.base
          ?.copyWithSize(DSTextStyleSize.sm)
          .copyWithColor(_textColor),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: _componentTheme.borderRadius?.borderRadiusGeometry,
      ),
      padding: _componentTheme.padding,
      waitDuration: Duration(milliseconds: _waitDuration),
      showDuration: Duration(seconds: _showDuration),
      verticalOffset: _verticalOffset,
      child: widget.child,
    );
  }
}
