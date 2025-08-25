// ignore_for_file: flutter_style_todos

import '../base/base_service.dart';

/// Template for creating a new service
/// Copy this file and modify it according to your needs
class ServiceTemplate extends BaseService {
  ServiceTemplate._();
  static final ServiceTemplate instance = ServiceTemplate._();

  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    logInfo('Initializing service template...');
    // TODO: Add your initialization logic here
    _initialized = true;
    logInfo('Service template initialized successfully');
  }

  @override
  Future<void> dispose() async {
    if (!_initialized) {
      return;
    }

    logInfo('Disposing service template...');
    // TODO: Add your disposal logic here
    _initialized = false;
    logInfo('Service template disposed successfully');
  }

  @override
  bool get isInitialized => _initialized;

  @override
  String get serviceName => 'ServiceTemplate';

  //////////////////////////////////////////////////////////////////
  ///                    Public API Methods                       ///
  //////////////////////////////////////////////////////////////////

  /// Example public method
  Future<String> exampleMethod() async {
    if (!_initialized) {
      throw Exception('Service is not initialized');
    }

    try {
      // TODO: Add your method implementation here
      return 'Example result';
    } catch (e) {
      handleError(e, context: 'exampleMethod');
      rethrow;
    }
  }

  //////////////////////////////////////////////////////////////////
  ///                    Private Helper Methods                    ///
  //////////////////////////////////////////////////////////////////

  /// Example private method
  // ignore: unused_element
  void _examplePrivateMethod() {
    // TODO: Add your private method implementation here
  }
}
