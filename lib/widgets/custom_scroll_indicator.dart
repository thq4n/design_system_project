import 'package:flutter/material.dart';

/// Custom scroll indicator widget với hiệu ứng bouncing
///
/// Widget này tạo ra một indicator trượt trên thanh nền với hiệu ứng bouncing
/// khi scroll đến các cận của scroll view.
class CustomScrollIndicator extends StatelessWidget {
  /// ScrollController để theo dõi vị trí scroll
  final ScrollController scrollController;

  /// Chiều rộng của thanh indicator
  final double scrollBarWidth;

  /// Chiều rộng của thumb (phần trượt)
  final double thumbWidth;

  /// Màu sắc của thumb
  final Color thumbColor;

  /// Màu sắc của track (thanh nền)
  final Color trackColor;

  /// Hệ số bouncing (0.0 - 1.0)
  final double bounceFactor;

  /// Chiều cao của indicator
  final double height;

  /// Border radius của indicator
  final double borderRadius;

  /// Margin của container
  final EdgeInsetsGeometry margin;

  const CustomScrollIndicator({
    super.key,
    required this.scrollController,
    required this.scrollBarWidth,
    required this.thumbWidth,
    required this.thumbColor,
    required this.trackColor,
    this.bounceFactor = 0.3,
    this.height = 4.0,
    this.borderRadius = 2.0,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        margin: margin,
        width: scrollBarWidth,
        child: AnimatedBuilder(
          animation: scrollController,
          builder: (context, child) {
            double positionLeft = 0.0;
            double bounceOffset = 0.0;

            if (scrollController.hasClients &&
                scrollController.position.hasContentDimensions) {
              final maxScroll = scrollController.position.maxScrollExtent;
              final currentScroll = scrollController.offset;

              final progress = maxScroll > 0
                  ? (currentScroll / maxScroll).clamp(0.0, 1.0)
                  : 0.0;

              final availableScrollArea = scrollBarWidth - thumbWidth;
              positionLeft = progress * availableScrollArea;

              // Tính toán hiệu ứng bouncing
              if (currentScroll <= 0) {
                // Bouncing khi ở cận trái - indicator di chuyển ngược lại
                bounceOffset = currentScroll * bounceFactor;
              } else if (currentScroll >= maxScroll) {
                // Bouncing khi ở cận phải
                bounceOffset = (currentScroll - maxScroll) * bounceFactor;
              } else {
                bounceOffset = 0.0;
              }
            }

            return Container(
              width: scrollBarWidth,
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: positionLeft + bounceOffset,
                    child: Container(
                      width: thumbWidth,
                      height: height,
                      decoration: BoxDecoration(
                        color: thumbColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
