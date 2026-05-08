import 'dart:async';

class DSHardwareScannerStatus {
  const DSHardwareScannerStatus({required this.isScanning});

  final bool isScanning;
}

abstract class DSHardwareScannerAdapter {
  Future<bool> isAvailable();

  Future<void> initialize();

  Future<void> dispose();

  Stream<String> get scanStream;

  Stream<DSHardwareScannerStatus> get statusStream;
}
