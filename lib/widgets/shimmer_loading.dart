import 'package:flutter/material.dart';
import '../design_system_core/ds_color_usage/ds_color_usage_core.dart';

/// A shimmer loading widget that provides a beautiful loading animation effect.
///
/// This widget creates a shimmer effect that can be applied to any child widget
/// to show a loading state. The shimmer effect moves across the widget with
/// a gradient animation.
///
/// Example usage:
/// ```dart
/// Shimmer(
///   linearGradient: shimmerGradient,
///   child: ListView(
///     children: [
///       ShimmerLoading(
///         isLoading: true,
///         child: YourWidget(),
///       ),
///     ],
///   ),
/// )
/// ```
class Shimmer extends StatefulWidget {
  /// Returns the ShimmerState from the widget tree.
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  /// Creates a shimmer widget with default design system gradient.
  static Widget withDefaultGradient({required Widget child}) {
    return Shimmer(
      linearGradient: _defaultShimmerGradient,
      child: child,
    );
  }

  /// Creates a shimmer widget with light gray gradient (subtle effect).
  static Widget withLightGradient({required Widget child}) {
    return Shimmer(
      linearGradient: _lightShimmerGradient,
      child: child,
    );
  }

  /// Creates a shimmer widget with medium gray gradient (standard effect).
  static Widget withMediumGradient({required Widget child}) {
    return Shimmer(
      linearGradient: _mediumShimmerGradient,
      child: child,
    );
  }

  /// Creates a shimmer widget with dark gray gradient (strong effect).
  static Widget withDarkGradient({required Widget child}) {
    return Shimmer(
      linearGradient: _darkShimmerGradient,
      child: child,
    );
  }

  /// Creates a shimmer widget with brand color gradient.
  static Widget withBrandGradient({required Widget child}) {
    return Shimmer(
      linearGradient: _brandShimmerGradient,
      child: child,
    );
  }

  /// Creates a shimmer widget with rainbow gradient effect.
  static Widget withRainbowGradient({required Widget child}) {
    return Shimmer(
      linearGradient: _rainbowShimmerGradient,
      child: child,
    );
  }

  /// Creates a shimmer widget with pulse effect.
  static Widget withPulseEffect({required Widget child}) {
    return Shimmer(
      linearGradient: _pulseShimmerGradient,
      child: child,
    );
  }

  /// Creates a shimmer widget with wave effect.
  static Widget withWaveEffect({required Widget child}) {
    return Shimmer(
      linearGradient: _waveShimmerGradient,
      child: child,
    );
  }

  /// Default shimmer gradient using design system gray colors.
  static const LinearGradient _defaultShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFF1F4F5), // DSColors.gray.tint100
      Color(0xFFE5E5E5), // DSColors.gray.tint200
      Color(0xFFF1F4F5), // DSColors.gray.tint100
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Light shimmer gradient for subtle effects.
  static const LinearGradient _lightShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFF9FAFB), // DSColors.gray.tint50
      Color(0xFFF1F4F5), // DSColors.gray.tint100
      Color(0xFFF9FAFB), // DSColors.gray.tint50
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Medium shimmer gradient for standard effects.
  static const LinearGradient _mediumShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFE5E5E5), // DSColors.gray.tint200
      Color(0xFFD4D4D4), // DSColors.gray.tint300
      Color(0xFFE5E5E5), // DSColors.gray.tint200
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Dark shimmer gradient for strong effects.
  static const LinearGradient _darkShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFD4D4D4), // DSColors.gray.tint300
      Color(0xFFA3A3A3), // DSColors.gray.tint400
      Color(0xFFD4D4D4), // DSColors.gray.tint300
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Brand shimmer gradient using brand colors.
  static const LinearGradient _brandShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFFEE4E2), // DSColors.brand.tint100
      Color(0xFFFECDCA), // DSColors.brand.tint200
      Color(0xFFFEE4E2), // DSColors.brand.tint100
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Rainbow shimmer gradient for colorful effects.
  static const LinearGradient _rainbowShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFFEE4E2), // Brand tint100
      Color(0xFFE5E5E5), // Gray tint200
      Color(0xFFF1F4F5), // Gray tint100
      Color(0xFFE5E5E5), // Gray tint200
      Color(0xFFFEE4E2), // Brand tint100
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Pulse shimmer gradient for pulsing effect.
  static const LinearGradient _pulseShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFF1F4F5), // Gray tint100
      Color(0xFFE5E5E5), // Gray tint200
      Color(0xFFD4D4D4), // Gray tint300
      Color(0xFFE5E5E5), // Gray tint200
      Color(0xFFF1F4F5), // Gray tint100
    ],
    stops: [0.0, 0.2, 0.5, 0.8, 1.0],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Wave shimmer gradient for wave effect.
  static const LinearGradient _waveShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFF9FAFB), // Gray tint50
      Color(0xFFF1F4F5), // Gray tint100
      Color(0xFFE5E5E5), // Gray tint200
      Color(0xFFF1F4F5), // Gray tint100
      Color(0xFFF9FAFB), // Gray tint50
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  /// Creates a shimmer widget.
  ///
  /// [linearGradient] is the gradient used for the shimmer effect.
  /// [child] is the child widget.
  const Shimmer({
    super.key,
    required this.linearGradient,
    this.child,
  });

  /// The gradient used for the shimmer effect.
  final LinearGradient linearGradient;

  /// The child widget.
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

/// The state for the Shimmer widget.
class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this);

    // Start the animation with proper error handling
    try {
      _shimmerController.repeat(
        min: 0.0,
        max: 1.0,
        period: const Duration(milliseconds: 1000),
      );
    } catch (e) {
      // Fallback to simple repeat if the above fails
      _shimmerController.repeat(period: const Duration(milliseconds: 1000));
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  /// The gradient with the current animation transform applied.
  LinearGradient get gradient {
    try {
      return LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: _SlidingGradientTransform(
          slidePercent: _shimmerController.value,
        ),
      );
    } catch (e) {
      // Fallback to original gradient if transform fails
      return widget.linearGradient;
    }
  }

  /// Whether the shimmer widget has been sized.
  bool get isSized {
    try {
      final renderBox = context.findRenderObject() as RenderBox?;
      return renderBox?.hasSize ?? false;
    } catch (e) {
      return false;
    }
  }

  /// The size of the shimmer widget.
  Size get size {
    try {
      final renderBox = context.findRenderObject() as RenderBox?;
      return renderBox?.size ?? Size.zero;
    } catch (e) {
      return Size.zero;
    }
  }

  /// Gets the offset of a descendant widget within the shimmer.
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    try {
      final shimmerBox = context.findRenderObject() as RenderBox?;
      if (shimmerBox == null) {
        return Offset.zero;
      }
      return descendant.localToGlobal(offset, ancestor: shimmerBox);
    } catch (e) {
      return Offset.zero;
    }
  }

  /// The listenable for shimmer changes.
  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return widget.child ?? const SizedBox();
      },
    );
  }
}

/// A gradient transform that slides the gradient horizontally.
class _SlidingGradientTransform extends GradientTransform {
  /// Creates a sliding gradient transform.
  ///
  /// [slidePercent] is the percentage to slide the gradient.
  const _SlidingGradientTransform({required this.slidePercent});

  /// The percentage to slide the gradient.
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    try {
      // Convert the 0-1 animation value to a sliding effect
      // We want the shimmer to slide from left (-1.0) to right (2.0)
      final slideOffset = (slidePercent * 3.0) - 1.0;
      return Matrix4.translationValues(
        bounds.width * slideOffset,
        0.0,
        0.0,
      );
    } catch (e) {
      // Fallback to no transform if calculation fails
      return null;
    }
  }
}

/// A shimmer loading widget that applies the shimmer effect to its child.
///
/// This widget should be used as a descendant of a Shimmer widget.
class ShimmerLoading extends StatefulWidget {
  /// Creates a shimmer loading widget.
  ///
  /// [isLoading] determines if the shimmer effect is active.
  /// [child] is the widget to apply the shimmer effect to.
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  /// The child widget to apply the shimmer effect to.
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // Update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // Collect ancestor shimmer info.
    final shimmer = Shimmer.of(context);
    if (shimmer == null) {
      // If no ancestor Shimmer widget, return the child without shimmer
      return widget.child;
    }

    if (!shimmer.isSized) {
      // The ancestor Shimmer widget has not laid itself out yet.
      return const SizedBox();
    }

    return AnimatedBuilder(
      animation: shimmer.shimmerChanges,
      builder: (context, child) {
        final shimmerSize = shimmer.size;
        final gradient = shimmer.gradient;

        // Get the render object safely
        final renderObject = context.findRenderObject();
        if (renderObject == null || !renderObject.attached) {
          return widget.child;
        }

        final offsetWithinShimmer = shimmer.getDescendantOffset(
          descendant: renderObject as RenderBox,
        );

        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return gradient.createShader(
              Rect.fromLTWH(
                -offsetWithinShimmer.dx,
                -offsetWithinShimmer.dy,
                shimmerSize.width,
                shimmerSize.height,
              ),
            );
          },
          child: widget.child,
        );
      },
    );
  }
}

/// A shimmer skeleton widget for common loading patterns.
///
/// This widget provides pre-built shimmer skeletons for common UI patterns
/// like cards, list items, and avatars.
class ShimmerSkeleton extends StatelessWidget {
  /// Creates a shimmer skeleton widget.
  ///
  /// [type] is the type of skeleton to display.
  /// [isLoading] determines if the shimmer effect is active.
  /// [child] is the child widget to show when not loading.
  const ShimmerSkeleton({
    super.key,
    required this.type,
    required this.isLoading,
    this.child,
  });

  /// The type of skeleton to display.
  final ShimmerSkeletonType type;

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  /// The child widget to show when not loading.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (!isLoading && child != null) {
      return child!;
    }

    return ShimmerLoading(
      isLoading: isLoading,
      child: _buildSkeleton(),
    );
  }

  Widget _buildSkeleton() {
    switch (type) {
      case ShimmerSkeletonType.card:
        return _buildCardSkeleton();
      case ShimmerSkeletonType.listItem:
        return _buildListItemSkeleton();
      case ShimmerSkeletonType.avatar:
        return _buildAvatarSkeleton();
      case ShimmerSkeletonType.text:
        return _buildTextSkeleton();
      case ShimmerSkeletonType.button:
        return _buildButtonSkeleton();
      case ShimmerSkeletonType.chip:
        return _buildChipSkeleton();
      case ShimmerSkeletonType.progress:
        return _buildProgressSkeleton();
      case ShimmerSkeletonType.custom:
        return child ?? const SizedBox();
    }
  }

  Widget _buildCardSkeleton() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: DSColorUsages
            .background.secondary, // Using design system background color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and text
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 120,
                        decoration: BoxDecoration(
                          color: DSColorUsages.background.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 12,
                        width: 80,
                        decoration: BoxDecoration(
                          color: DSColorUsages.background.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Content lines
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: DSColorUsages.background.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: DSColorUsages.background.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: 200,
              decoration: BoxDecoration(
                color: DSColorUsages.background.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Spacer(),
            // Footer with action buttons
            Row(
              children: [
                Container(
                  height: 32,
                  width: 80,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemSkeleton() {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: DSColorUsages
            .background.secondary, // Using design system background color
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Left side - image or icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: DSColorUsages.background.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            // Right side - content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: DSColorUsages.background.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 150,
                    decoration: BoxDecoration(
                      color: DSColorUsages.background.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 60,
                        decoration: BoxDecoration(
                          color: DSColorUsages.background.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: DSColorUsages.background.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSkeleton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: DSColorUsages
            .background.secondary, // Using design system background color
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: DSColorUsages.background.primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildTextSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title line
        Container(
          height: 18,
          width: double.infinity,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        // Subtitle line
        Container(
          height: 14,
          width: 200,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        // Description lines
        Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 12,
          width: 180,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 12,
          width: 160,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonSkeleton() {
    return Container(
      height: 48,
      width: 120,
      decoration: BoxDecoration(
        color: DSColorUsages.background.secondary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Container(
          height: 16,
          width: 60,
          decoration: BoxDecoration(
            color: DSColorUsages.background.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildChipSkeleton() {
    return Container(
      height: 32,
      width: 80,
      decoration: BoxDecoration(
        color: DSColorUsages.background.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Container(
          height: 12,
          width: 40,
          decoration: BoxDecoration(
            color: DSColorUsages.background.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 14,
              width: 60,
              decoration: BoxDecoration(
                color: DSColorUsages.background.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: 14,
              width: 30,
              decoration: BoxDecoration(
                color: DSColorUsages.background.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: DSColorUsages.background.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.7, // 70% progress
            child: Container(
              decoration: BoxDecoration(
                color: DSColorUsages.background.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The types of shimmer skeletons available.
enum ShimmerSkeletonType {
  /// A card-like skeleton.
  card,

  /// A list item skeleton.
  listItem,

  /// An avatar skeleton.
  avatar,

  /// A text skeleton.
  text,

  /// A button skeleton.
  button,

  /// A chip skeleton.
  chip,

  /// A progress skeleton.
  progress,

  /// A custom skeleton using the child widget.
  custom,
}
