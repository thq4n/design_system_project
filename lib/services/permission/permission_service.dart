import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../base/base_service.dart';

export 'package:permission_handler/permission_handler.dart';

/// Service for handling permission requests and checks using permission_handler
class PermissionService extends BaseService {
  PermissionService._();

  static final PermissionService instance = PermissionService._();

  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    logInfo('Initializing permission service...');
    _initialized = true;
    logInfo('Permission service initialized successfully');
  }

  @override
  Future<void> dispose() async {
    if (!_initialized) {
      return;
    }

    logInfo('Disposing permission service...');
    _initialized = false;
    logInfo('Permission service disposed successfully');
  }

  @override
  bool get isInitialized => _initialized;

  @override
  String get serviceName => 'PermissionService';

  //////////////////////////////////////////////////////////////////
  ///                    Private Helper Methods                    ///
  //////////////////////////////////////////////////////////////////

  /// Checks if the app is running in E2E test environment
  // TODO(gianthieuquan): Replace with actual E2E check
  bool get _isE2ETest => false;

  bool _isMediaLibraryPermission(Permission permission) {
    return permission == Permission.photos ||
        permission == Permission.videos ||
        permission == Permission.storage;
  }

  bool _isPermissionAllowed(Permission permission, PermissionStatus status) {
    if (status.isGranted) {
      return true;
    }
    if (status.isLimited && _isMediaLibraryPermission(permission)) {
      return true;
    }
    return false;
  }

  /// Get permission status using permission_handler
  Future<PermissionStatus> _getPermissionStatus(Permission permission) async {
    try {
      final status = await permission.status;
      return status;
    } catch (e) {
      handleError(e, context: 'getPermissionStatus');
      return PermissionStatus.denied;
    }
  }

  /// Request permission using permission_handler
  Future<PermissionStatus> _requestPermissionStatus(
    Permission permission,
  ) async {
    try {
      final status = await permission.request();
      return status;
    } catch (e) {
      handleError(e, context: 'requestPermissionStatus');
      return PermissionStatus.denied;
    }
  }

  /// Requests a single permission with proper error handling
  Future<bool> _requestPermission(
    Permission permission,
    BuildContext context, {
    bool awaitWarningDialog = false,
    bool showWarningDialog = true,
  }) async {
    if (_isE2ETest) {
      /// In integration test env we do not support need to request permission
      return false;
    }

    var status = await _getPermissionStatus(permission);

    if (_isPermissionAllowed(permission, status)) {
      return true;
    }

    // Handle location permission special case for iOS
    if (permission == Permission.locationAlways && Platform.isIOS) {
      return _handleIOSLocationPermission(
        context,
        showWarningDialog,
        awaitWarningDialog,
      );
    }

    // Request permission if denied
    if (status.isDenied) {
      status = await _requestPermissionStatus(permission);
    }

    // Show warning dialog if permanently denied or restricted
    if (showWarningDialog &&
        (status.isPermanentlyDenied || status.isRestricted)) {
      if (awaitWarningDialog) {
        await _showPermissionWarningDialog(context);
      } else {
        unawaited(_showPermissionWarningDialog(context));
      }
      return false;
    }

    return _isPermissionAllowed(permission, status);
  }

  /// Handles iOS location permission special case
  Future<bool> _handleIOSLocationPermission(
    BuildContext context,
    bool showWarningDialog,
    bool awaitWarningDialog,
  ) async {
    final canRequest = await _getPermissionStatus(Permission.locationWhenInUse);

    if (!canRequest.isGranted) {
      final granted =
          await _requestPermissionStatus(Permission.locationWhenInUse);
      if (!granted.isGranted) {
        return false;
      }
    }

    final status = await _requestPermissionStatus(Permission.locationAlways);

    if (showWarningDialog &&
        (status.isPermanentlyDenied || status.isRestricted)) {
      if (awaitWarningDialog) {
        await _showPermissionWarningDialog(context);
      } else {
        unawaited(_showPermissionWarningDialog(context));
      }
      return false;
    }

    return status.isGranted;
  }

  /// Shows permission warning dialog
  Future<void> _showPermissionWarningDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cần cấp quyền'),
        content: const Text(
          'Ứng dụng cần quyền để hoạt động. '
          'Vui lòng bật trong Cài đặt.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Mở Cài đặt'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _openAppSettings();
    }
  }

  /// Open app settings using permission_handler
  Future<void> _openAppSettings() async {
    await openAppSettings();
  }

  //////////////////////////////////////////////////////////////////
  ///                    Public API Methods                       ///
  //////////////////////////////////////////////////////////////////

  /// Checks if a permission is granted
  Future<bool> checkPermission(
    Permission permission,
    BuildContext context,
  ) async {
    if (_isE2ETest) {
      return false;
    }

    final status = await _getPermissionStatus(permission);
    return _isPermissionAllowed(permission, status);
  }

  /// Checks multiple permissions and returns their status
  Future<List<bool>> checkPermissions(
    List<Permission> permissions,
    BuildContext context,
  ) async {
    final results = <bool>[];

    for (final permission in permissions) {
      final isGranted = await checkPermission(permission, context);
      results.add(isGranted);
    }

    return results;
  }

  /// Requests a single permission
  Future<bool> requestPermission(
    Permission permission,
    BuildContext context, {
    bool awaitWarningDialog = false,
    bool showWarningDialog = true,
  }) async {
    var isGranted = await checkPermission(permission, context);
    if (!isGranted) {
      isGranted = await _requestPermission(
        permission,
        context,
        awaitWarningDialog: awaitWarningDialog,
        showWarningDialog: showWarningDialog,
      );
    }

    return isGranted;
  }

  /// Requests multiple permissions
  Future<List<bool>> requestPermissions(
    List<Permission> permissions,
    BuildContext context, {
    bool showWarningDialog = true,
  }) async {
    final results = <bool>[];

    for (final permission in permissions) {
      final isGranted = await requestPermission(
        permission,
        context,
        awaitWarningDialog: true,
        showWarningDialog: showWarningDialog,
      );
      results.add(isGranted);
    }

    return results;
  }

  /// Opens app settings
  Future<void> openAppSetting() async {
    await _openAppSettings();
  }

  //////////////////////////////////////////////////////////////////
  ///                    Convenience Methods                      ///
  //////////////////////////////////////////////////////////////////

  /// Gets Android SDK version
  Future<int?> _getAndroidSdkVersion() async {
    if (!Platform.isAndroid) {
      return null;
    }
    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    } catch (e) {
      handleError(e, context: 'getAndroidSdkVersion');
      return null;
    }
  }

  /// Requests camera permission
  Future<bool> requestCameraPermission(
    BuildContext context, {
    bool showWarningDialog = true,
  }) async {
    return requestPermission(
      Permission.camera,
      context,
      showWarningDialog: showWarningDialog,
    );
  }

  /// Requests microphone permission
  Future<bool> requestMicrophonePermission(
    BuildContext context, {
    bool showWarningDialog = true,
  }) async {
    return requestPermission(
      Permission.microphone,
      context,
      showWarningDialog: showWarningDialog,
    );
  }

  /// Requests location permission
  Future<bool> requestLocationPermission(
    BuildContext context, {
    bool showWarningDialog = true,
  }) async {
    return requestPermission(
      Permission.location,
      context,
      showWarningDialog: showWarningDialog,
    );
  }

  /// Requests storage permission
  ///
  /// For Android:
  /// - Android 12 (API 32) or lower: uses Permission.storage
  /// - Android 13 (API 33) and above: uses Permission.photos
  ///
  /// For iOS:
  /// - Uses Permission.photos
  Future<bool> requestStoragePermission(
    BuildContext context, {
    bool showWarningDialog = true,
  }) async {
    Permission permission;

    if (Platform.isIOS) {
      // iOS uses Permission.photos
      permission = Permission.photos;
    } else if (Platform.isAndroid) {
      // Android: check SDK version
      // Android 12 (API 32) or lower: use Permission.storage
      // Android 13 (API 33) and above: use Permission.photos
      final sdkVersion = await _getAndroidSdkVersion();
      if (sdkVersion != null && sdkVersion >= 33) {
        // Android 13 (API 33) and above
        permission = Permission.photos;
      } else {
        // Android 12 (API 32) or lower
        permission = Permission.storage;
      }
    } else {
      // Fallback for other platforms
      permission = Permission.storage;
    }

    return requestPermission(
      permission,
      context,
      showWarningDialog: showWarningDialog,
    );
  }

  /// Requests photo library permission
  Future<bool> requestPhotoLibraryPermission(
    BuildContext context, {
    bool showWarningDialog = true,
  }) async {
    return requestPermission(
      Permission.photos,
      context,
      showWarningDialog: showWarningDialog,
    );
  }

  /// Requests notification permission
  Future<bool> requestNotificationPermission(
    BuildContext context, {
    bool showWarningDialog = true,
  }) async {
    return requestPermission(
      Permission.notification,
      context,
      showWarningDialog: showWarningDialog,
    );
  }
}
