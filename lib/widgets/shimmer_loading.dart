import 'package:flutter/material.dart';

/// A shimmer loading widget that provides a beautiful loading animation effect.
///
/// This widget creates a shimmer effect that can be applied to any child widget
/// to show a loading state. The shimmer effect moves across the widget with
/// a gradient animation.
///
/// Example usage:
/// ```dart
/// ShimmerLoading(
///   isLoading: true,
///   child: Container(
///     height: 100,
///     decoration: BoxDecoration(
///       color: Colors.grey[300],
///       borderRadius: BorderRadius.circular(8),
///     ),
///   ),
/// )
/// ```
class ShimmerLoading extends StatefulWidget {
  /// Whether the shimmer effect should be active.
  final bool isLoading;

  /// The child widget to apply the shimmer effect to.
  final Widget child;

  /// The gradient used for the shimmer effect.
  ///
  /// Defaults to a light gray shimmer gradient.
  final LinearGradient? shimmerGradient;

  /// The duration of one complete shimmer cycle.
  ///
  /// Defaults to 1000 milliseconds.
  final Duration duration;

  /// Creates a shimmer loading widget.
  ///
  /// [isLoading] determines if the shimmer effect is active.
  /// [child] is the widget to apply the shimmer effect to.
  /// [shimmerGradient] is the gradient for the shimmer effect.
  /// [duration] is the duration of one complete shimmer cycle.
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
    this.shimmerGradient,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  Listenable? _shimmerChanges;

  /// Default shimmer gradient with light gray colors.
  static const LinearGradient _defaultShimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: widget.duration,
      );
  }

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
    _shimmerController.dispose();
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
      // If no ancestor Shimmer widget, wrap with one
      return Shimmer(
        linearGradient: widget.shimmerGradient ?? _defaultShimmerGradient,
        child: _buildShimmerEffect(),
      );
    }

    if (!shimmer.isSized) {
      // The ancestor Shimmer widget has not laid itself out yet.
      return const SizedBox();
    }

    return _buildShimmerEffect();
  }

  Widget _buildShimmerEffect() {
    final shimmer = Shimmer.of(context);
    if (shimmer == null) return widget.child;

    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
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
  }
}

/// A shimmer widget that provides the shimmer animation context.
///
/// This widget should be placed as an ancestor to ShimmerLoading widgets
/// to provide the shimmer animation context.
class Shimmer extends StatefulWidget {
  /// Returns the ShimmerState from the widget tree.
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

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
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(milliseconds: 1000),
      );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  /// The gradient with the current animation transform applied.
  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: _SlidingGradientTransform(
          slidePercent: _shimmerController.value,
        ),
      );

  /// Whether the shimmer widget has been sized.
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  /// The size of the shimmer widget.
  Size get size => (context.findRenderObject() as RenderBox).size;

  /// Gets the offset of a descendant widget within the shimmer.
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  /// The listenable for shimmer changes.
  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

/// A gradient transform that slides the gradient horizontally.
class _SlidingGradientTransform extends GradientTransform {
  /// Creates a sliding gradient transform.
  ///
  /// [slidePercent] is the percentage to slide the gradient (0.0 to 1.0).
  const _SlidingGradientTransform({required this.slidePercent});

  /// The percentage to slide the gradient.
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * slidePercent,
      0.0,
      0.0,
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
      case ShimmerSkeletonType.custom:
        return child ?? const SizedBox();
    }
  }

  Widget _buildCardSkeleton() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildListItemSkeleton() {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildAvatarSkeleton() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTextSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 16,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 16,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
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

  /// A custom skeleton using the child widget.
  custom,
}
