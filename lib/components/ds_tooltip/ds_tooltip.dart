import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../base/ds_base.dart';
import '../../design_system_core/ds_color/ds_colors_core.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../design_system_core/ds_radius/ds_radius_core.dart';
import '../../theme/ds_theme.dart';

class DSTooltipController {
  final SuperTooltipController _controller = SuperTooltipController();

  Future<void> show() => _controller.showTooltip();

  Future<void> hide() => _controller.hideTooltip();

  bool get isVisible => _controller.isVisible;

  void dispose() => _controller.dispose();
}

class DSTooltip extends StatefulWidget {
  final String label;
  final DSColor? backgroundColor;
  final DSColor? textColor;
  final double? verticalOffset;
  final int? waitDuration;
  final int? showDuration;
  final Widget child;
  final bool? preferBelow;
  final DSTooltipController? controller;
  final bool showOnTap;

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
    this.controller,
    this.showOnTap = true,
  });

  @override
  State<DSTooltip> createState() => _DSTooltipState();
}

class _DSTooltipState extends DSStateBase<DSTooltip> {
  late final DSTooltipTheme _componentTheme =
      Theme.of(context).extension<DSTooltipThemeExtension>()!.tooltipTheme;
  late final DSTooltipController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? DSTooltipController();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ??
        _componentTheme.boxDecoration?.color ??
        DSColorUsages.background.primary.black;
    final textStyle = widget.textColor != null
        ? _componentTheme.textStyle?.copyWith(color: widget.textColor)
        : _componentTheme.textStyle;
    final preferBelow = widget.preferBelow ?? false;

    return SuperTooltip(
      controller: _controller._controller,
      content: Text(
        widget.label,
        style: textStyle,
        textAlign: TextAlign.start,
      ),
      style: TooltipStyle(
        backgroundColor: backgroundColor,
        borderWidth: 0,
        borderRadius: DSRadiuses.radiusSm.x,
        hasShadow: false,
        bubbleDimensions: _componentTheme.padding ?? EdgeInsets.zero,
      ),
      arrowConfig: const ArrowConfiguration(
        length: 6,
        baseWidth: 12,
        tipDistance: 2,
      ),
      barrierConfig: const BarrierConfiguration(
        show: true,
        color: Colors.transparent,
      ),
      positionConfig: PositionConfiguration(
        preferredDirection:
            preferBelow ? TooltipDirection.down : TooltipDirection.up,
        verticalOffset:
            widget.verticalOffset ?? _componentTheme.verticalOffset ?? 0,
      ),
      interactionConfig: InteractionConfiguration(
        showOnTap: widget.showOnTap,
        hideOnBarrierTap: true,
      ),
      animationConfig: AnimationConfiguration(
        waitDuration: widget.waitDuration != null
            ? Duration(milliseconds: widget.waitDuration!)
            : _componentTheme.waitDuration ?? Duration.zero,
        showDuration: widget.showDuration != null
            ? Duration(milliseconds: widget.showDuration!)
            : _componentTheme.showDuration,
      ),
      constraints: const BoxConstraints(maxWidth: 280),
      child: widget.child,
    );
  }
}
