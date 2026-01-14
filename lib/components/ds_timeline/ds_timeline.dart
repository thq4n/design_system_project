import 'package:flutter/material.dart';

import '../../design_system_project.dart';

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

  /// Whether to show a loading node at the end of the timeline.
  /// When true, a skeleton loading node with location icon will be displayed.
  final bool isLoading;

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
    this.isLoading = false,
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
    bool isLoading = false,
  }) {
    return DSTimeline<T>(
      key: key,
      items: items,
      itemBuilder: itemBuilder,
      loadingItemBuilder: loadingItemBuilder,
      isLoading: isLoading,
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
  List<AnimationController> _controllers = [];
  List<Animation<double>> _fadeAnimations = [];
  List<Animation<Offset>> _slideAnimations = [];
  List<Animation<double>> _lineAnimations = [];
  AnimationController? _loadingNodeController;
  Animation<double>? _loadingNodeFadeAnimation;
  Animation<Offset>? _loadingNodeSlideAnimation;
  AnimationController? _loadingConnectorController;
  Animation<double>? _loadingConnectorAnimation;
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

  @override
  void didUpdateWidget(DSTimeline<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-initialize animations if item count changed or isLoading changed
    if ((oldWidget.items.length != widget.items.length ||
            oldWidget.isLoading != widget.isLoading) &&
        _animationsInitialized) {
      // Dispose old controllers
      for (final controller in _controllers) {
        controller.dispose();
      }
      _loadingNodeController?.dispose();
      _loadingConnectorController?.dispose();
      // Re-initialize with new item count
      _initializeAnimations();
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

    // Initialize loading node animations if isLoading is true
    if (widget.isLoading) {
      _loadingNodeController = AnimationController(
        vsync: this,
        duration: _componentTheme.animationDuration,
      );

      _loadingNodeFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _loadingNodeController!,
          curve: Curves.easeOut,
        ),
      );

      _loadingNodeSlideAnimation = Tween<Offset>(
        begin: const Offset(-0.2, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _loadingNodeController!,
          curve: Curves.easeOutCubic,
        ),
      );

      // Initialize loading connector animation
      //(repeating animation for dash loading effect)
      _loadingConnectorController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      );

      _loadingConnectorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _loadingConnectorController!,
          curve: Curves.linear,
        ),
      );

      // Start loading connector animation immediately and repeat
      _loadingConnectorController!.repeat();

      // Start loading node animation after all items are animated
      final delay = _componentTheme.animationDelay * widget.items.length;
      Future.delayed(delay, () {
        if (mounted && _loadingNodeController != null) {
          _loadingNodeController!.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    if (_animationsInitialized) {
      for (final controller in _controllers) {
        controller.dispose();
      }
      _loadingNodeController?.dispose();
      _loadingConnectorController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int index = 0; index < widget.items.length; index++) {
      final isLast = index == widget.items.length - 1 && !widget.isLoading;
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
      final isNextLoading =
          !isLast && widget.isLoading && index == widget.items.length - 1;
      children.add(
        _buildTimelineItem(
          index: index,
          item: item,
          isLast: isLast,
          isNextLoading: isNextLoading,
        ),
      );
    }

    // Add loading node if isLoading is true
    if (widget.isLoading) {
      children.add(_buildLoadingNode());
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
    bool isNextLoading = false,
  }) {
    // Safety check: ensure animations are initialized and index is valid
    if (!_animationsInitialized ||
        index >= _fadeAnimations.length ||
        index >= _slideAnimations.length ||
        index >= _lineAnimations.length) {
      // Return non-animated version if animations aren't ready
      final isNextLoading =
          !isLast && widget.isLoading && index == widget.items.length - 1;
      return _buildTimelineItemWithoutAnimation(
        index: index,
        item: item,
        isLast: isLast,
        isNextLoading: isNextLoading,
      );
    }

    final dotColor = _componentTheme.dotColor;
    final dotMargin = _componentTheme.dotMargin;
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
                        margin: dotMargin,
                        width: dotSize - dotMargin.vertical,
                        height: dotSize - dotMargin.vertical,
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
                    child: isNextLoading
                        ? AnimatedBuilder(
                            animation: _loadingConnectorAnimation ??
                                _lineAnimations[index],
                            builder: (context, child) {
                              return CustomPaint(
                                painter: _LoadingDashedConnectorPainter(
                                  color: const DSColors().gray.shape500,
                                  thickness: connectorThickness,
                                  progress: _lineAnimations[index].value,
                                  loadingProgress:
                                      _loadingConnectorAnimation?.value ?? 0.0,
                                ),
                                child: Container(),
                              );
                            },
                          )
                        : AnimatedBuilder(
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

  Widget _buildTimelineItemWithoutAnimation({
    required int index,
    required T item,
    required bool isLast,
    bool isNextLoading = false,
  }) {
    // Get theme safely - use existing if initialized,
    // otherwise get from context
    final theme = _animationsInitialized
        ? _componentTheme
        : Theme.of(context)
            .extension<DSTimelineThemeExtension>()
            ?.getDSTimelineTheme();

    if (theme == null) {
      // If theme is not available, return a simple placeholder
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: widget.itemBuilder(context, item, index),
      );
    }

    final dotColor = theme.dotColor;
    final dotMargin = theme.dotMargin;
    final dotSize = theme.dotSize;
    final dotBorderColor = theme.dotBorderColor;
    final dotBorderThickness = theme.dotBorderThickness;
    final connectorColor = theme.connectorColor;
    final connectorThickness = theme.connectorThickness;
    final itemSpacing = theme.itemSpacing;
    final horizontalSpacing = theme.horizontalSpacing;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Dot and connector
          SizedBox(
            width: dotSize,
            child: Column(
              children: [
                // Dot indicator (non-animated)
                Container(
                  margin: dotMargin,
                  width: dotSize - dotMargin.vertical,
                  height: dotSize - dotMargin.vertical,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                    border: Border.all(
                      color: dotBorderColor,
                      width: dotBorderThickness,
                    ),
                  ),
                ),
                // Connector line
                if (!isLast)
                  Expanded(
                    child: isNextLoading && _loadingConnectorAnimation != null
                        ? AnimatedBuilder(
                            animation: _loadingConnectorAnimation!,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: _LoadingDashedConnectorPainter(
                                  color: const DSColors().gray.shape500,
                                  thickness: connectorThickness,
                                  progress: 1.0,
                                  loadingProgress:
                                      _loadingConnectorAnimation!.value,
                                ),
                                child: Container(),
                              );
                            },
                          )
                        : CustomPaint(
                            painter: isNextLoading
                                ? _DashedConnectorPainter(
                                    color: const DSColors().gray.shape500,
                                    thickness: connectorThickness,
                                    progress: 1.0,
                                  )
                                : _ConnectorPainter(
                                    color: connectorColor,
                                    thickness: connectorThickness,
                                    progress: 1.0,
                                  ),
                            child: Container(),
                          ),
                  )
                else
                  SizedBox(height: itemSpacing),
              ],
            ),
          ),
          SizedBox(width: horizontalSpacing),
          // Right side: Content card (non-animated)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: itemSpacing),
              child: widget.itemBuilder(context, item, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingNode() {
    final dotSize = _componentTheme.dotSize;
    final horizontalSpacing = _componentTheme.horizontalSpacing;
    const colors = DSColors();

    // Check if animations are initialized
    if (!_animationsInitialized ||
        _loadingNodeController == null ||
        _loadingNodeFadeAnimation == null ||
        _loadingNodeSlideAnimation == null) {
      // Return non-animated version if animations aren't ready
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side: Dot with location icon (static, no shimmer)
            DSImageView(
              source: DSAssets.vuesax.locationBold,
              width: dotSize,
              height: dotSize,
              color: colors.gray.shape400,
            ),
            SizedBox(width: horizontalSpacing),
            // Right side: Skeleton loading content
            Expanded(
              child: widget.loadingItemBuilder ??
                  Shimmer.withDefaultGradient(
                    child: const ShimmerSkeleton(
                      type: ShimmerSkeletonType.listItem,
                      isLoading: true,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                    ),
                  ),
            ),
          ],
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Dot with location icon (static, no shimmer)
          AnimatedBuilder(
            animation: _loadingNodeFadeAnimation!,
            builder: (context, child) {
              return Opacity(
                opacity: _loadingNodeFadeAnimation!.value,
                child: DSImageView(
                  source: DSAssets.vuesax.locationBold,
                  width: dotSize,
                  height: dotSize,
                  color: colors.gray.shape400,
                ),
              );
            },
          ),
          SizedBox(width: horizontalSpacing),
          // Right side: Skeleton loading content
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _loadingNodeFadeAnimation!,
                _loadingNodeSlideAnimation!,
              ]),
              builder: (context, child) {
                return Opacity(
                  opacity: _loadingNodeFadeAnimation!.value,
                  child: SlideTransition(
                    position: _loadingNodeSlideAnimation!,
                    child: widget.loadingItemBuilder ??
                        Shimmer.withDefaultGradient(
                          child: const ShimmerSkeleton(
                            type: ShimmerSkeletonType.listItem,
                            isLoading: true,
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                          ),
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

/// Custom painter for the dashed connector line with animation
class _DashedConnectorPainter extends CustomPainter {
  final DSColor color;
  final double thickness;
  final double progress;

  _DashedConnectorPainter({
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

    // Draw dashed line
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double currentY = startY;

    while (currentY < endY) {
      final dashEnd = (currentY + dashWidth).clamp(0.0, endY);
      canvas.drawLine(
        Offset(size.width / 2, currentY),
        Offset(size.width / 2, dashEnd),
        paint,
      );
      currentY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedConnectorPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.thickness != thickness;
  }
}

/// Custom painter for the loading dashed
/// connector line with animated dash effect
/// Dashes appear one by one from top to bottom in a repeating animation
class _LoadingDashedConnectorPainter extends CustomPainter {
  final DSColor color;
  final double thickness;
  final double progress;
  final double loadingProgress;

  _LoadingDashedConnectorPainter({
    required this.color,
    required this.thickness,
    required this.progress,
    required this.loadingProgress,
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

    // Draw dashed line with loading animation
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    const totalDashLength = dashWidth + dashSpace;

    // Calculate the maximum Y position where dashes should be visible
    // loadingProgress goes from 0.0 to 1.0, repeating
    // We want dashes to appear from top to bottom, then repeat
    final maxVisibleY = startY + (endY - startY) * loadingProgress;

    double currentY = startY;
    while (currentY < endY) {
      // Only draw dash if its start position is within the visible range
      if (currentY < maxVisibleY) {
        final dashEnd = (currentY + dashWidth).clamp(0.0, endY);
        // Clamp dash end to maxVisibleY to create smooth reveal effect
        final clampedDashEnd = dashEnd > maxVisibleY ? maxVisibleY : dashEnd;
        if (clampedDashEnd > currentY) {
          canvas.drawLine(
            Offset(size.width / 2, currentY),
            Offset(size.width / 2, clampedDashEnd),
            paint,
          );
        }
      }
      currentY += totalDashLength;
    }
  }

  @override
  bool shouldRepaint(_LoadingDashedConnectorPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.loadingProgress != loadingProgress ||
        oldDelegate.color != color ||
        oldDelegate.thickness != thickness;
  }
}
