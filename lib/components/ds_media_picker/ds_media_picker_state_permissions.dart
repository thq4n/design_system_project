part of 'ds_media_picker.dart';

extension _DSMediaPickerStatePermissions on _DSMediaPickerState {
  Future<int?> _getAndroidSdkVersion() async {
    if (!Platform.isAndroid) {
      return null;
    }
    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    } catch (e) {
      return null;
    }
  }

  Future<bool> _checkAndRequestPermissions() async {
    final permissions = <Permission>[];
    final needsCamera = widget.mediaSource == DSMediaSource.camera ||
        widget.mediaSource == DSMediaSource.both;
    final needsGallery = widget.mediaSource == DSMediaSource.gallery ||
        widget.mediaSource == DSMediaSource.both;
    final isPhotoOnly = widget.mediaType == DSMediaPickerType.photo;
    final isVideoOnly = widget.mediaType == DSMediaPickerType.video;

    if (needsCamera) {
      permissions.add(Permission.camera);
    }

    if (needsGallery) {
      if (Platform.isIOS) {
        permissions.add(Permission.photos);
      } else if (Platform.isAndroid) {
        final sdkVersion = await _getAndroidSdkVersion();
        if (sdkVersion != null && sdkVersion >= 33) {
          if (isPhotoOnly) {
            permissions.add(Permission.photos);
          } else if (isVideoOnly) {
            permissions.add(Permission.videos);
          } else {
            permissions
              ..add(Permission.photos)
              ..add(Permission.videos);
          }
        } else {
          permissions.add(Permission.storage);
        }
      }
    }

    if (permissions.isEmpty) {
      return true;
    }
    final deduped = <Permission>[];
    for (final p in permissions) {
      if (!deduped.contains(p)) {
        deduped.add(p);
      }
    }

    try {
      final results = await PermissionService.instance.requestPermissions(
        deduped,
        context,
        showWarningDialog: true,
      );
      return results.length == deduped.length && results.every((e) => e);
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return false;
    }
  }

  Future<bool> _checkCameraPermission() async {
    try {
      return await PermissionService.instance.checkPermission(
        Permission.camera,
        context,
      );
    } catch (e) {
      debugPrint('Error checking camera permission: $e');
      return false;
    }
  }

  Future<bool> _checkPhotoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.checkPermission(
          Permission.photos,
          context,
        );
      } else {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.checkPermission(
            Permission.photos,
            context,
          );
        }
        return await PermissionService.instance.checkPermission(
          Permission.storage,
          context,
        );
      }
    } catch (e) {
      debugPrint('Error checking photo library permission: $e');
      return false;
    }
  }

  Future<bool> _checkVideoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.checkPermission(
          Permission.photos,
          context,
        );
      }
      if (Platform.isAndroid) {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.checkPermission(
            Permission.videos,
            context,
          );
        }
        return await PermissionService.instance.checkPermission(
          Permission.storage,
          context,
        );
      }
      return true;
    } catch (e) {
      debugPrint('Error checking video library permission: $e');
      return false;
    }
  }

  Future<bool> _requestCameraPermission() async {
    try {
      return await PermissionService.instance.requestCameraPermission(
        context,
        showWarningDialog: true,
      );
    } catch (e) {
      debugPrint('Error requesting camera permission: $e');
      return false;
    }
  }

  Future<bool> _requestPhotoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.requestPhotoLibraryPermission(
          context,
          showWarningDialog: true,
        );
      } else {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.requestPermissions(
            [Permission.photos],
            context,
            showWarningDialog: true,
          ).then((r) => r.isNotEmpty && r.every((e) => e));
        }
        return await PermissionService.instance.requestStoragePermission(
          context,
          showWarningDialog: true,
        );
      }
    } catch (e) {
      debugPrint('Error requesting photo library permission: $e');
      return false;
    }
  }

  Future<bool> _requestVideoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.requestPhotoLibraryPermission(
          context,
          showWarningDialog: true,
        );
      }
      if (Platform.isAndroid) {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.requestPermissions(
            [Permission.videos],
            context,
            showWarningDialog: true,
          ).then((r) => r.isNotEmpty && r.every((e) => e));
        }
        return await PermissionService.instance.requestStoragePermission(
          context,
          showWarningDialog: true,
        );
      }
      return true;
    } catch (e) {
      debugPrint('Error requesting video library permission: $e');
      return false;
    }
  }
}
