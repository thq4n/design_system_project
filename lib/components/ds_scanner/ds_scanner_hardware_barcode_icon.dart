import 'package:barcode_widget/barcode_widget.dart' as barcode_pkg;
import 'package:flutter/material.dart';

class DSScannerHardwareBarcodeIcon extends StatefulWidget {
  const DSScannerHardwareBarcodeIcon({
    super.key,
    required this.isScanning,
    required this.activeColor,
  });

  final bool isScanning;
  final Color activeColor;

  @override
  State<DSScannerHardwareBarcodeIcon> createState() =>
      _DSScannerHardwareBarcodeIconState();
}

class _DSScannerHardwareBarcodeIconState extends State<DSScannerHardwareBarcodeIcon>
    with TickerProviderStateMixin {
  static const Color _idleColor = Colors.grey;
  late final AnimationController _blinkController;
  late final Animation<double> _blinkAnimation;
  late final AnimationController _scanLineController;
  late final Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _blinkAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scanLineAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );
    if (widget.isScanning) {
      _blinkController.repeat(reverse: true);
      _scanLineController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant DSScannerHardwareBarcodeIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning) {
      if (!_blinkController.isAnimating) {
        _blinkController.repeat(reverse: true);
      }
      if (!_scanLineController.isAnimating) {
        _scanLineController.repeat();
      }
    } else {
      _blinkController.stop();
      _blinkController.reset();
      _scanLineController.stop();
      _scanLineController.reset();
    }
  }

  @override
  void dispose() {
    _blinkController.dispose();
    _scanLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_blinkAnimation, _scanLineAnimation]),
      builder: (context, child) {
        final barcodeColor = widget.isScanning
            ? Color.lerp(_idleColor, widget.activeColor, _blinkAnimation.value)!
            : _idleColor;
        return SizedBox(
          width: 120,
          height: 64,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: barcode_pkg.BarcodeWidget(
                  barcode: barcode_pkg.Barcode.code128(),
                  data: 'SCAN',
                  width: 100,
                  height: 48,
                  color: barcodeColor,
                  backgroundColor: Colors.transparent,
                  drawText: false,
                ),
              ),
              if (widget.isScanning)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final lineLeft =
                          _scanLineAnimation.value *
                              (constraints.maxWidth + 4) -
                          2;
                      return IgnorePointer(
                        child: CustomPaint(
                          size: Size(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ),
                          painter: _ScanLinePainter(
                            left: lineLeft,
                            color: widget.activeColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  _ScanLinePainter({required this.left, required this.color});

  final double left;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(left, 0), Offset(left, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _ScanLinePainter oldDelegate) {
    return oldDelegate.left != left || oldDelegate.color != color;
  }
}
