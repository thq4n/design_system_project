import 'package:flutter/material.dart';

import '../../design_system_project.dart';
export 'ds_expandable_controller.dart';

/// A customizable expandable/collapsible widget with header and body.
///
/// This widget displays a header that can be tapped to expand or collapse
/// the body content. The expansion/collapse is animated smoothly.
///
/// Example usage:
/// ```dart
/// // Without controller (uses internal state)
/// DSExpandable(
///   title: 'Lộ trình dự kiến (200 km)',
///   leadingIcon: DSAssets.vuesax.gpsLinear,
///   body: Text('Expanded content'),
///   initiallyExpanded: true,
/// )
///
/// // With controller (external control)
/// final controller = DSExpandableController(initiallyExpanded: false);
/// DSExpandable(
///   controller: controller,
///   title: 'My Title',
///   body: Text('Content'),
/// )
/// ```
class DSExpandable extends StatefulWidget {
  /// Controller for managing expansion state (optional).
  /// If provided, the widget will use this controller
  /// instead of internal state.
  final DSExpandableController? controller;

  /// The title text displayed in the header
  final String title;

  /// The leading icon asset path (optional)
  final String? leadingIcon;

  /// The body widget that expands/collapses
  final Widget body;

  /// Whether the widget is initially expanded
  /// (only used if controller is not provided)
  final bool initiallyExpanded;

  /// Margin around the entire widget
  final EdgeInsetsGeometry? margin;

  /// Callback when expansion state changes
  final ValueChanged<bool>? onExpansionChanged;

  const DSExpandable({
    super.key,
    this.controller,
    required this.title,
    this.leadingIcon,
    required this.body,
    this.initiallyExpanded = true,
    this.margin,
    this.onExpansionChanged,
  });

  @override
  State<DSExpandable> createState() => _DSExpandableState();
}

class _DSExpandableState extends State<DSExpandable> {
  late DSExpandableController _internalController;
  late DSExpandableController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _internalController = DSExpandableController(
        initiallyExpanded: widget.initiallyExpanded,
      );
      _controller = _internalController;
    }
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(DSExpandable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onControllerChanged);
      if (widget.controller != null) {
        _controller = widget.controller!;
      } else {
        if (oldWidget.controller == null) {
          _internalController.value = widget.initiallyExpanded;
        } else {
          _internalController = DSExpandableController(
            initiallyExpanded: widget.initiallyExpanded,
          );
        }
        _controller = _internalController;
      }
      _controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
      widget.onExpansionChanged?.call(_controller.value);
    }
  }

  void _toggleExpansion() {
    _controller.toggle();
  }

  bool get _isExpanded => _controller.value;

  Widget _buildHeader(BuildContext context, DSExpandableTheme theme) {
    final textTheme = context.textTheme;

    return Row(
      children: [
        if (widget.leadingIcon != null) ...[
          DSImageView(
            source: widget.leadingIcon!,
            height: theme.iconSize,
            width: theme.iconSize,
            color: theme.iconColor,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            widget.title,
            style: textTheme.lg?.semibold,
          ),
        ),
        AnimatedRotation(
          duration: theme.animationDuration,
          turns: _isExpanded ? 0 : 0.5,
          child: DSImageView(
            source: DSAssets.vuesax.arrowDown1Linear,
            height: theme.iconSize,
            width: theme.iconSize,
            color: theme.iconColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).dsExpandableTheme.getDSExpandableTheme();

    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: DSColorUsages.background.primary,
        borderRadius: theme.borderRadius.borderRadiusGeometry,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _toggleExpansion,
            borderRadius:
                theme.borderRadius.borderRadiusGeometry as BorderRadius?,
            child: Padding(
              padding: theme.headerPadding,
              child: _buildHeader(context, theme),
            ),
          ),
          AnimatedSize(
            duration: theme.animationDuration,
            curve: theme.animationCurve,
            alignment: Alignment.topCenter,
            child: _isExpanded
                ? Padding(
                    padding: theme.bodyPadding,
                    child: widget.body,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
