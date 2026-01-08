import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../design_system_core/ds_color/ds_colors_core.dart';
import '../../theme/ds_theme.dart';

/// A customizable timeline widget with animations.
///
/// This widget displays a vertical timeline with dots on the left
/// and content cards on the right.
/// Each node animates in with fade and slide effects,
/// and the connector line extends as nodes appear.
///
/// Example usage:
/// ```dart
/// DSTimeline<String>(
///   items: ['Item 1', 'Item 2', 'Item 3'],
///   itemBuilder: (context, item, index) {
///     return Card(
///       child: ListTile(
///         title: Text(item),
///       ),
///     );
///   },
///   separatorBuilder: (context, currentItem, currentIndex) {
///     // Return separator widget if needed before this item, or null to skip
///     // Example: Show separator before items at index 5, 15, 30 (group boundaries)
///     if (currentIndex == 5 || currentIndex == 15 || currentIndex == 30) {
///       return DSTimeline.buildDefaultSeparator(
///         context,
///         text: 'Group ${currentIndex}',
///       );
///     }
///     return null;
///   },
/// )
/// ```
class DSTimeline<T> extends StatefulWidget {
  /// List of data items to display in the timeline
  final List<T> items;

  /// Builder function to create the content card for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  final Widget? loadingItemBuilder;

  /// Builder function to create a separator before an item.
  /// Returns null if no separator is needed before this item.
  /// This allows grouping items with separators between groups.
  /// Parameters: (context, currentItem, currentIndex)
  ///
  /// Example: If you want separator before items at index 5, 15, 30:
  /// ```dart
  /// separatorBuilder: (context, item, index) {
  ///   if (index == 5 || index == 15 || index == 30) {
  ///     return DSTimeline.buildDefaultSeparator(
  ///       context,
  ///       text: 'Group ${index}',
  ///     );
  ///   }
  ///   return null;
  /// }
  /// ```
  final Widget? Function(
    BuildContext context,
    T currentItem,
    int currentIndex,
  )? separatorBuilder;

  const DSTimeline({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.loadingItemBuilder,
    this.separatorBuilder,
  });

  /// Static method to create a timeline with automatic grouping by a key.
  ///
  /// Items are automatically grouped by the key extracted from each item.
  /// A separator is shown before the first item of each group.
  ///
  /// Example:
  /// ```dart
  /// DSTimeline.groupedBy<Event, DateTime>(
  ///   items: events,
  ///   keySelector: (event) => event.date,
  ///   separatorTextBuilder: (date) => date.toLocalddmmyyyy(),
  ///   itemBuilder: (context, event, index) {
  ///     return EventCard(event: event);
  ///   },
  /// )
  /// ```
  static DSTimeline<T> groupedBy<T, K>({
    Key? key,
    required List<T> items,
    required K Function(T item) keySelector,
    required String Function(K key) separatorTextBuilder,
    required Widget Function(BuildContext context, T item, int index)
        itemBuilder,
    Widget? loadingItemBuilder,
    Widget? Function(BuildContext context, K key)? customSeparatorBuilder,
  }) {
    return DSTimeline<T>(
      key: key,
      items: items,
      itemBuilder: itemBuilder,
      loadingItemBuilder: loadingItemBuilder,
      separatorBuilder: (context, currentItem, currentIndex) {
        // Show separator before first item of each group
        if (currentIndex == 0) {
          final groupKey = keySelector(currentItem);
          if (customSeparatorBuilder != null) {
            return customSeparatorBuilder(context, groupKey);
          }
          return DSTimeline.buildDefaultSeparator(
            context,
            text: separatorTextBuilder(groupKey),
          );
        }

        // Check if this item starts a new group
        final previousItem = items[currentIndex - 1];
        final previousKey = keySelector(previousItem);
        final currentKey = keySelector(currentItem);

        if (previousKey != currentKey) {
          if (customSeparatorBuilder != null) {
            return customSeparatorBuilder(context, currentKey);
          }
          return DSTimeline.buildDefaultSeparator(
            context,
            text: separatorTextBuilder(currentKey),
          );
        }

        return null;
      },
    );
  }

  /// Helper method to build a default separator widget.
  /// This creates a row with text on the left
  /// and a line extending to the right.
  static Widget buildDefaultSeparator(
    BuildContext context, {
    required String text,
    Widget? customText,
  }) {
    final theme = Theme.of(context)
        .extension<DSTimelineThemeExtension>()
        ?.getDSTimelineTheme();
    if (theme == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: theme.separatorPadding,
      child: Row(
        children: [
          if (customText != null)
            customText
          else
            Text(
              text,
              style: theme.separatorTextStyle,
            ),
          Expanded(
            child: Container(
              height: theme.separatorLineThickness,
              margin: EdgeInsets.only(left: theme.horizontalSpacing),
              color: theme.separatorLineColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<DSTimeline<T>> createState() => _DSTimelineState<T>();
}

class _DSTimelineState<T> extends DSStateBase<DSTimeline<T>>
    with TickerProviderStateMixin {
  late DSTimelineTheme _componentTheme;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _lineAnimations;
  bool _animationsInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_animationsInitialized) {
      _componentTheme = Theme.of(context)
          .extension<DSTimelineThemeExtension>()!
          .getDSTimelineTheme();
      _initializeAnimations();
      _animationsInitialized = true;
    }
  }

  void _initializeAnimations() {
    final itemCount = widget.items.length;
    _controllers = List.generate(
      itemCount,
      (index) => AnimationController(
        vsync: this,
        duration: _componentTheme.animationDuration,
      ),
    );

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
    }).toList();

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(-0.2, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        ),
      );
    }).toList();

    _lineAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
    }).toList();

    // Start animations with delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(_componentTheme.animationDelay * i, () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int index = 0; index < widget.items.length; index++) {
      final isLast = index == widget.items.length - 1;
      final item = widget.items[index];

      // Add separator if needed (before this item)
      if (widget.separatorBuilder != null) {
        final separator = widget.separatorBuilder!(
          context,
          item,
          index,
        );
        if (separator != null) {
          children.add(separator);
        }
      }

      // Add timeline item
      children.add(
        _buildTimelineItem(
          index: index,
          item: item,
          isLast: isLast,
        ),
      );
    }

    return Padding(
      padding: _componentTheme.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTimelineItem({
    required int index,
    required T item,
    required bool isLast,
  }) {
    final dotColor = _componentTheme.dotColor;
    final dotSize = _componentTheme.dotSize;
    final dotBorderColor = _componentTheme.dotBorderColor;
    final dotBorderThickness = _componentTheme.dotBorderThickness;
    final connectorColor = _componentTheme.connectorColor;
    final connectorThickness = _componentTheme.connectorThickness;
    final itemSpacing = _componentTheme.itemSpacing;
    final horizontalSpacing = _componentTheme.horizontalSpacing;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Dot and connector
          SizedBox(
            width: dotSize,
            child: Column(
              children: [
                // Dot indicator
                AnimatedBuilder(
                  animation: _fadeAnimations[index],
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimations[index].value,
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dotColor,
                          border: Border.all(
                            color: dotBorderColor,
                            width: dotBorderThickness,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Connector line
                if (!isLast)
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _lineAnimations[index],
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _ConnectorPainter(
                            color: connectorColor,
                            thickness: connectorThickness,
                            progress: _lineAnimations[index].value,
                          ),
                          child: Container(),
                        );
                      },
                    ),
                  )
                else
                  SizedBox(height: itemSpacing),
              ],
            ),
          ),
          SizedBox(width: horizontalSpacing),
          // Right side: Content card
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _fadeAnimations[index],
                _slideAnimations[index],
              ]),
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimations[index].value,
                  child: SlideTransition(
                    position: _slideAnimations[index],
                    child: Padding(
                      padding: EdgeInsets.only(bottom: itemSpacing),
                      child: widget.itemBuilder(context, item, index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the connector line with animation
class _ConnectorPainter extends CustomPainter {
  final DSColor color;
  final double thickness;
  final double progress;

  _ConnectorPainter({
    required this.color,
    required this.thickness,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) {
      return;
    }

    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    const startY = 0.0;
    final endY = size.height * progress;

    canvas.drawLine(
      Offset(size.width / 2, startY),
      Offset(size.width / 2, endY),
      paint,
    );
  }

  @override
  bool shouldRepaint(_ConnectorPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.thickness != thickness;
  }
}
