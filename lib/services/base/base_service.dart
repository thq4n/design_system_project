import 'package:flutter/material.dart';

/// Base class for all services
/// Provides common functionality and lifecycle management
abstract class BaseService {
  const BaseService();

  /// Initialize the service
  /// Called when the service is first created
  Future<void> initialize();

  /// Dispose the service
  /// Called when the service is no longer needed
  Future<void> dispose();

  /// Check if the service is initialized
  bool get isInitialized;

  /// Get service name for logging/debugging
  String get serviceName;

  /// Handle errors in a consistent way
  void handleError(dynamic error, {String? context}) {
    debugPrint(
      '[$serviceName] Error: $error ${context != null ? '($context)' : ''}',
    );
  }

  /// Log information in a consistent way
  void logInfo(String message) {
    debugPrint('[$serviceName] Info: $message');
  }

  /// Log warnings in a consistent way
  void logWarning(String message) {
    debugPrint('[$serviceName] Warning: $message');
  }
}
