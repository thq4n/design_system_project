import 'package:flutter/material.dart';
import 'base/base_service.dart';

/// Service Manager to handle initialization and disposal of all services
class ServiceManager {
  static final ServiceManager _instance = ServiceManager._internal();
  factory ServiceManager() => _instance;
  ServiceManager._internal();

  final Map<Type, BaseService> _services = {};
  bool _isInitialized = false;

  /// Get a service by type
  T getService<T extends BaseService>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T is not registered');
    }
    return service as T;
  }

  /// Register a service
  void registerService<T extends BaseService>(T service) {
    _services[T] = service;
    debugPrint('Service registered: ${service.serviceName}');
  }

  /// Initialize all registered services
  Future<void> initializeAll() async {
    if (_isInitialized) {
      debugPrint('ServiceManager already initialized');
      return;
    }

    debugPrint('Initializing ${_services.length} services...');

    for (final service in _services.values) {
      try {
        await service.initialize();
        debugPrint('Service initialized: ${service.serviceName}');
      } catch (e) {
        service.handleError(e, context: 'initialization');
      }
    }

    _isInitialized = true;
    debugPrint('All services initialized successfully');
  }

  /// Dispose all services
  Future<void> disposeAll() async {
    debugPrint('Disposing ${_services.length} services...');

    for (final service in _services.values) {
      try {
        await service.dispose();
        debugPrint('Service disposed: ${service.serviceName}');
      } catch (e) {
        service.handleError(e, context: 'disposal');
      }
    }

    _services.clear();
    _isInitialized = false;
    debugPrint('All services disposed successfully');
  }

  /// Check if all services are initialized
  bool get isInitialized => _isInitialized;

  /// Get all registered services
  List<BaseService> get allServices => _services.values.toList();

  /// Get service count
  int get serviceCount => _services.length;
}
