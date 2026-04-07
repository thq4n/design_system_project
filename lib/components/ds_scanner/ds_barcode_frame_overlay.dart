import 'package:flutter/material.dart';

import '../../design_system_core/ds_color/ds_colors_core.dart';

class DSBarcodeFrameOverlay extends StatefulWidget {
  const DSBarcodeFrameOverlay({
    super.key,
    this.color,
    this.isBlinking = true,
    this.period = const Duration(milliseconds: 900),
  });

  final Color? color;
  final bool isBlinking;
  final Duration period;

  @override
  State<DSBarcodeFrameOverlay> createState() => _DSBarcodeFrameOverlayState();
}

class _DSBarcodeFrameOverlayState extends State<DSBarcodeFrameOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _syncController();
  }

  @override
  void didUpdateWidget(covariant DSBarcodeFrameOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isBlinking != widget.isBlinking ||
        oldWidget.period != widget.period) {
      _syncController();
    }
  }

  void _syncController() {
    _controller?.dispose();
    _controller = null;

    if (!widget.isBlinking) {
      setState(() {});
      return;
    }

    _controller = AnimationController(vsync: this, duration: widget.period)
      ..repeat(reverse: true);
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final resolvedColor = widget.color ?? const DSColors().gray.shade50;
    if (controller == null) {
      return IgnorePointer(
        child: CustomPaint(
          painter: _BarcodeFramePainter(color: resolvedColor, t: 1),
        ),
      );
    }

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _BarcodeFramePainter(
              color: resolvedColor,
              t: controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _BarcodeFramePainter extends CustomPainter {
  const _BarcodeFramePainter({required this.color, required this.t});

  final Color color;
  final double t;

  static const Size _viewBox = Size(256, 187);
  static const double _strokeWidth = 8;

  static const Color _shadowA = Color(0x08400000);
  static const Color _shadowB = Color(0x14400000);

  @override
  void paint(Canvas canvas, Size size) {
    final alpha = (0.55 + (0.45 * t)).clamp(0.0, 1.0);
    final glowAlpha = (0.15 + (0.35 * t)).clamp(0.0, 1.0);

    final scale = _uniformScale(size, _viewBox);
    final dx = (size.width - _viewBox.width * scale) / 2;
    final dy = (size.height - _viewBox.height * scale) / 2;

    final transform = Matrix4.identity()
      ..translateByDouble(dx, dy, 0.0, 1.0)
      ..scaleByDouble(scale, scale, 1.0, 1.0);

    final paths =
        _svgPaths().map((p) => p.transform(transform.storage)).toList();

    final strokeW = _strokeWidth * scale;

    final shadowPaintA = Paint()
      ..color = _shadowA.withValues(alpha: _shadowA.a * glowAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4 * scale);

    final shadowPaintB = Paint()
      ..color = _shadowB.withValues(alpha: _shadowB.a * glowAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12 * scale);

    final framePaint = Paint()
      ..color = color.withValues(alpha: alpha.toDouble())
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final path in paths) {
      canvas
        ..drawPath(path, shadowPaintB)
        ..drawPath(path, shadowPaintA)
        ..drawPath(path, framePaint);
    }
  }

  List<Path> _svgPaths() {
    return [
      Path()
        ..moveTo(61.1719, 24.1013)
        ..cubicTo(38.9761, 23.5171, 22.4247, 27.6067, 24.1167, 56.0879),
      Path()
        ..moveTo(231.942, 56.0889)
        ..cubicTo(232.619, 36.9291, 227.881, 22.6417, 194.887, 24.1023),
      Path()
        ..moveTo(231.942, 130.579)
        ..cubicTo(232.619, 149.739, 227.881, 164.026, 194.887, 162.566),
      Path()
        ..moveTo(61.1719, 162.566)
        ..cubicTo(28.1776, 164.026, 23.44, 149.739, 24.1168, 130.579)
        ..lineTo(24.1168, 135.91),
    ];
  }

  double _uniformScale(Size target, Size source) {
    if (target.width <= 0 || target.height <= 0) {
      return 1;
    }
    final sx = target.width / source.width;
    final sy = target.height / source.height;
    return sx < sy ? sx : sy;
  }

  @override
  bool shouldRepaint(covariant _BarcodeFramePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.t != t;
  }
}
