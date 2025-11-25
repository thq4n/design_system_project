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
  final bool? preferBelow;
  const DSTooltip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.verticalOffset,
    this.waitDuration,
    this.showDuration,
    required this.child,
    this.preferBelow = false,
  });

  @override
  State<DSTooltip> createState() => _DSTooltipState();
}

class _DSTooltipState extends DSStateBase<DSTooltip> {
  late final DSTooltipTheme _componentTheme =
      Theme.of(context).extension<DSTooltipThemeExtension>()!.tooltipTheme;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      textStyle: _componentTheme.textStyle,
      decoration: _componentTheme.boxDecoration,
      padding: _componentTheme.padding,
      waitDuration: _componentTheme.waitDuration,
      showDuration: _componentTheme.showDuration,
      verticalOffset: _componentTheme.verticalOffset,
      preferBelow: widget.preferBelow,
      child: widget.child,
    );
  }
}
