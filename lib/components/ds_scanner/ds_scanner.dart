import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../constants/constants.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../services/permission/permission_service.dart';
import '../ds_image_view/ds_image_view.dart';
import '../ds_input/ds_input.dart';
import 'ds_barcode_frame_overlay.dart';
import 'ds_hardware_scanner_adapter.dart';
import 'ds_scanner_hardware_barcode_icon.dart';

enum DSScannerViewMode {
  scan,
  manual,
}

class DSScanner extends StatefulWidget {
  const DSScanner({
    super.key,
    required this.viewMode,
    required this.onCodeScanned,
    required this.manualInputController,
    required this.onManualSubmitted,
    required this.heroTagModeSwitch,
    this.modeTransitionDuration = const Duration(milliseconds: 300),
    this.scannerHeight = 240,
    this.scannerHeightHardware = 100,
    this.barcodeFrameWidth = 256,
    this.barcodeFrameHeight = 187,
    this.hardwareScanner,
    this.manualInputTitle = 'Nhập mã vận đơn',
    this.manualInputHint = 'Nhập mã...',
    this.cameraPermissionDeniedMessage = 'Cần cấp quyền camera để quét',
    this.cameraScanHint = 'Đưa mã vào giữa khung để quét',
    this.hardwareScannerHint = 'Dùng nút scan trên thiết bị',
    this.barcodeController,
    this.shouldDispatchScannedCode,
    this.cameraSameCodeDedupeDuration = Duration.zero,
  });

  final ValueNotifier<DSScannerViewMode> viewMode;
  final ValueChanged<String> onCodeScanned;
  final DSInputController manualInputController;
  final ValueChanged<String> onManualSubmitted;
  final String heroTagModeSwitch;
  final Duration modeTransitionDuration;
  final double scannerHeight;
  final double scannerHeightHardware;
  final double barcodeFrameWidth;
  final double barcodeFrameHeight;
  final DSHardwareScannerAdapter? hardwareScanner;
  final String manualInputTitle;
  final String manualInputHint;
  final String cameraPermissionDeniedMessage;
  final dynamic cameraScanHint;
  final String hardwareScannerHint;
  final MobileScannerController? barcodeController;

  /// Khi set: chỉ gọi [onCodeScanned] và rung khi trả về `true` (camera + scanner thiết bị).
  final bool Function(String code)? shouldDispatchScannedCode;

  /// Bỏ qua cùng một mã từ camera trong khoảng thời gian này (nhập tay không áp dụng).
  final Duration cameraSameCodeDedupeDuration;

  @override
  State<DSScanner> createState() => _DSScannerState();
}

class _DSScannerState extends State<DSScanner> {
  late final MobileScannerController _barcodeController =
      widget.barcodeController ??
          MobileScannerController(
            cameraResolution: const Size(1280, 720),
          );
  final _cameraPermissionNotifier = ValueNotifier<bool>(false);
  final _useHardwareScannerNotifier = ValueNotifier<bool>(false);
  final _isHardwareScanningNotifier = ValueNotifier<bool>(false);

  StreamSubscription<String>? _hardwareScanSubscription;
  StreamSubscription<DSHardwareScannerStatus>? _hardwareStatusSubscription;
  bool _hardwareScannerAvailable = false;
  void Function()? _hardwareModeListener;
  String? _lastCameraScannedCode;
  DateTime? _lastCameraScannedAt;

  @override
  void initState() {
    super.initState();
    _handleCameraPermission();
    _checkHardwareScannerAndSync();
  }

  @override
  void dispose() {
    if (_hardwareModeListener != null) {
      _useHardwareScannerNotifier.removeListener(_hardwareModeListener!);
    }
    _stopHardwareScanner();
    unawaited(widget.hardwareScanner?.dispose());
    _barcodeController.dispose();
    _cameraPermissionNotifier.dispose();
    _useHardwareScannerNotifier.dispose();
    _isHardwareScanningNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleCameraPermission() async {
    try {
      final permissionService = PermissionService.instance;
      final hasPermission = await permissionService.checkPermission(
        Permission.camera,
        context,
      );
      if (!mounted) {
        return;
      }
      _cameraPermissionNotifier.value = hasPermission;
      if (!hasPermission) {
        final granted = await permissionService.requestCameraPermission(
          context,
        );
        _cameraPermissionNotifier.value = granted;
      }
    } catch (e) {
      if (mounted) {
        _cameraPermissionNotifier.value = false;
      }
    }
  }

  void _checkHardwareScannerAndSync() {
    final adapter = widget.hardwareScanner;
    if (adapter == null) {
      _hardwareScannerAvailable = false;
      _useHardwareScannerNotifier.value = false;
      return;
    }
    adapter.isAvailable().then((available) {
      if (!mounted) {
        return;
      }
      setState(() => _hardwareScannerAvailable = available);
      if (available) {
        _useHardwareScannerNotifier.value = true;
        _hardwareModeListener ??= _syncHardwareScannerWithMode;
        _useHardwareScannerNotifier.addListener(_hardwareModeListener!);
      } else {
        _useHardwareScannerNotifier.value = false;
      }
      _syncHardwareScannerWithMode();
    });
  }

  void _syncHardwareScannerWithMode() {
    if (_hardwareScannerAvailable) {
      unawaited(_startHardwareScanner());
    } else {
      _stopHardwareScanner();
    }
  }

  Future<void> _startHardwareScanner() async {
    final adapter = widget.hardwareScanner;
    if (adapter == null) {
      return;
    }
    _stopHardwareScanner();
    await adapter.initialize();
    if (!mounted) {
      return;
    }
    _hardwareScanSubscription = adapter.scanStream.listen((code) {
      if (!mounted) {
        return;
      }
      _dispatchScannedCode(code, fromCamera: true);
    });
    final previousStatusSub = _hardwareStatusSubscription;
    _hardwareStatusSubscription = adapter.statusStream.listen((status) {
      if (!mounted) {
        return;
      }
      if (_isHardwareScanningNotifier.value != status.isScanning) {
        _isHardwareScanningNotifier.value = status.isScanning;
      }
    });
    if (previousStatusSub != null) {
      unawaited(previousStatusSub.cancel());
    }
  }

  void _stopHardwareScanner() {
    _hardwareScanSubscription?.cancel();
    _hardwareScanSubscription = null;
    _hardwareStatusSubscription?.cancel();
    _hardwareStatusSubscription = null;
    _isHardwareScanningNotifier.value = false;
  }

  void _onBarcodeFromCamera(Barcode? barcode) {
    if (barcode?.rawValue == null) {
      return;
    }
    _dispatchScannedCode(barcode!.rawValue!, fromCamera: true);
  }

  void _dispatchScannedCode(String rawValue, {required bool fromCamera}) {
    final trimmed = rawValue.trim();
    if (trimmed.isEmpty) {
      return;
    }

    if (fromCamera && widget.cameraSameCodeDedupeDuration > Duration.zero) {
      final scannedAt = DateTime.now();
      if (_lastCameraScannedCode == trimmed &&
          _lastCameraScannedAt != null &&
          scannedAt.difference(_lastCameraScannedAt!) <
              widget.cameraSameCodeDedupeDuration) {
        return;
      }
    }

    final shouldDispatch =
        widget.shouldDispatchScannedCode?.call(trimmed) ?? true;
    if (!shouldDispatch) {
      return;
    }

    if (fromCamera && widget.cameraSameCodeDedupeDuration > Duration.zero) {
      _lastCameraScannedCode = trimmed;
      _lastCameraScannedAt = DateTime.now();
    }

    widget.onCodeScanned(trimmed);
    HapticFeedback.mediumImpact();
  }

  Widget _buildModeSwitchHero({
    required String icon,
    required VoidCallback onTap,
    double? width,
    double? height,
  }) {
    return Hero(
      tag: widget.heroTagModeSwitch,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: DSColorUsages.background.secondary,
              shape: BoxShape.circle,
            ),
            child: DSImageView(
              source: icon,
              width: width ?? DSIconSizes.size24,
              height: height ?? DSIconSizes.size24,
              color: context.colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScannerStrip() {
    return ValueListenableBuilder<bool>(
      valueListenable: _useHardwareScannerNotifier,
      builder: (context, useHardware, _) {
        final showCamera = !_hardwareScannerAvailable || !useHardware;
        final sectionHeight =
            showCamera ? widget.scannerHeight : widget.scannerHeightHardware;
        return ValueListenableBuilder<bool>(
          valueListenable: _isHardwareScanningNotifier,
          builder: (context, isHardwareScanning, _) {
            return ValueListenableBuilder<bool>(
              valueListenable: _cameraPermissionNotifier,
              builder: (context, hasPermission, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: sectionHeight,
                  width: double.infinity,
                  child: showCamera
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            if (hasPermission)
                              MobileScanner(
                                controller: _barcodeController,
                                onDetect: (result) {
                                  final list = result.barcodes;
                                  final first =
                                      list.isEmpty ? null : list.first;
                                  _onBarcodeFromCamera(first);
                                },
                              )
                            else
                              Container(
                                color: context.colors.gray.shade200,
                                child: Center(
                                  child: Text(
                                    widget.cameraPermissionDeniedMessage,
                                    style: TextStyle(
                                      color: context.colors.gray.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            if (hasPermission)
                              Center(
                                child: SizedBox(
                                  width: widget.barcodeFrameWidth,
                                  height: widget.barcodeFrameHeight,
                                  child: const DSBarcodeFrameOverlay(),
                                ),
                              ),
                            if (!useHardware || !_hardwareScannerAvailable)
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(130),
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      if (widget.cameraScanHint is String?) {
                                        return Text(
                                          widget.cameraScanHint ??
                                              'Đưa mã vào giữa khung để quét',
                                          style: context.textTheme.xs?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }

                                      if (widget.cameraScanHint is Widget) {
                                        return widget.cameraScanHint;
                                      }

                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              ),
                            AnimatedPositioned(
                              duration: widget.modeTransitionDuration,
                              left: 16,
                              bottom: 16,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildModeSwitchHero(
                                    icon: DSAssets.vuesax.keyboardBulk,
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      widget.viewMode.value =
                                          DSScannerViewMode.manual;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (_hardwareScannerAvailable)
                              AnimatedPositioned(
                                duration: widget.modeTransitionDuration,
                                right: 16,
                                bottom: 16,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildModeSwitchHero(
                                      icon: DSAssets.vuesax.barcodeBulk,
                                      onTap: () {
                                        HapticFeedback.selectionClick();
                                        _useHardwareScannerNotifier.value =
                                            true;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        )
                      : Center(
                          child: Stack(
                            children: [
                              Container(
                                color: context.colors.gray.white,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DSScannerHardwareBarcodeIcon(
                                      isScanning: isHardwareScanning,
                                      activeColor: context.colors.brand.primary,
                                    ),
                                    Text(
                                      widget.hardwareScannerHint,
                                      style: context.textTheme.sm?.copyWith(
                                        color: DSColorUsages.text.secondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedPositioned(
                                duration: widget.modeTransitionDuration,
                                right: 4,
                                bottom: 4,
                                child: _buildModeSwitchHero(
                                  icon: DSAssets.vuesax.cameraBulk,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    _useHardwareScannerNotifier.value = false;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildManualSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildModeSwitchHero(
          icon: DSAssets.vuesax.scanBulk,
          onTap: () {
            HapticFeedback.selectionClick();
            widget.viewMode.value = DSScannerViewMode.scan;
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DSInput(
            controller: widget.manualInputController,
            title: widget.manualInputTitle,
            hint: widget.manualInputHint,
            textCapitalization: TextCapitalization.characters,
            onSubmitted: (text, _) => widget.onManualSubmitted(text),
            suffixIcon: GestureDetector(
              onTap: () =>
                  widget.onManualSubmitted(widget.manualInputController.text),
              child: DSImageView(
                source: DSAssets.vuesax.addCircleBold,
                width: DSIconSizes.size24,
                height: DSIconSizes.size24,
                color: context.colors.blue,
              ),
            ),
            withClearButton: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DSScannerViewMode>(
      valueListenable: widget.viewMode,
      builder: (context, mode, _) {
        final isScanMode = mode == DSScannerViewMode.scan;
        return Material(
          color: DSColorUsages.background.primary,
          child: AnimatedSize(
            duration: widget.modeTransitionDuration,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isScanMode
                ? _buildScannerStrip()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: _buildManualSection(),
                  ),
          ),
        );
      },
    );
  }
}
