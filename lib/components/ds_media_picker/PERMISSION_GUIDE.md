# DS Media Picker - Permission Guide

Hướng dẫn chi tiết về cách kiểm tra và request quyền cần thiết cho component `DSMediaPicker`.

## 📋 Quyền cần thiết

### Android
- `android.permission.CAMERA` - Quyền truy cập camera
- `android.permission.READ_EXTERNAL_STORAGE` - Quyền đọc thư viện ảnh
- `android.permission.WRITE_EXTERNAL_STORAGE` - Quyền ghi file (cho Android < 10)

### iOS
- `NSCameraUsageDescription` - Quyền truy cập camera
- `NSPhotoLibraryUsageDescription` - Quyền truy cập thư viện ảnh

## 🔧 Cấu hình Platform

### Android Manifest (`android/app/src/main/AndroidManifest.xml`)

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Camera permission -->
    <uses-permission android:name="android.permission.CAMERA" />
    
    <!-- Storage permissions -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" 
        android:maxSdkVersion="28" />
    
    <!-- Feature declarations -->
    <uses-feature android:name="android.hardware.camera" android:required="false" />
    <uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
    
    <application>
        <!-- ... rest of your app configuration ... -->
    </application>
</manifest>
```

### iOS Info.plist (`ios/Runner/Info.plist`)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Camera permission -->
    <key>NSCameraUsageDescription</key>
    <string>Ứng dụng cần quyền truy cập camera để chụp ảnh và quay video</string>
    
    <!-- Photo library permission -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Ứng dụng cần quyền truy cập thư viện ảnh để chọn ảnh và video</string>
    
    <!-- ... rest of your app configuration ... -->
</dict>
</plist>
```

## 🚀 Cách sử dụng

### 1. Kiểm tra quyền trước khi sử dụng

```dart
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:design_system_project/services/permission/permission_service.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _hasCameraPermission = false;
  bool _hasPhotoLibraryPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // Kiểm tra quyền camera
    final cameraPermission = await PermissionService.instance.checkPermission(
      Permission.camera,
      context,
    );

    // Kiểm tra quyền thư viện ảnh
    final photoLibraryPermission = await PermissionService.instance.checkPermission(
      Platform.isIOS ? Permission.photos : Permission.storage,
      context,
    );

    setState(() {
      _hasCameraPermission = cameraPermission;
      _hasPhotoLibraryPermission = photoLibraryPermission;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hiển thị trạng thái quyền
        _buildPermissionStatus(),
        
        // Media picker
        if (_hasCameraPermission && _hasPhotoLibraryPermission)
          DSMediaPicker(
            controller: _controller,
            mediaSource: DSMediaSource.both,
            saveLocalFolder: 'my_media',
          )
        else
          ElevatedButton(
            onPressed: _requestPermissions,
            child: Text('Yêu cầu quyền'),
          ),
      ],
    );
  }

  Widget _buildPermissionStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPermissionItem('Camera', _hasCameraPermission),
            _buildPermissionItem('Thư viện ảnh', _hasPhotoLibraryPermission),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionItem(String title, bool hasPermission) {
    return Row(
      children: [
        Icon(
          hasPermission ? Icons.check_circle : Icons.cancel,
          color: hasPermission ? Colors.green : Colors.red,
        ),
        SizedBox(width: 8),
        Text(title),
        Spacer(),
        Text(hasPermission ? 'Đã cấp' : 'Chưa cấp'),
      ],
    );
  }

  Future<void> _requestPermissions() async {
    final permissions = <Permission>[
      Permission.camera,
      Platform.isIOS ? Permission.photos : Permission.storage,
    ];

    final results = await PermissionService.instance.requestPermissions(
      permissions,
      context,
      showWarningDialog: true,
    );

    setState(() {
      _hasCameraPermission = results[0];
      _hasPhotoLibraryPermission = results[1];
    });
  }
}
```

### 2. Sử dụng với permission handling tự động

```dart
DSMediaPicker(
  controller: _controller,
  mediaType: DSMediaPickerType.both,
  mediaSource: DSMediaSource.both,
  maxImageMedia: 5,
  maxVideoMedia: 5,
  crossAxisCount: 3,
  saveLocalFolder: 'auto_permission_media',
  autoUpload: false,
  onMediaPicked: (medias) {
    print('Đã chọn ${medias.length} media');
  },
)
```

### 3. Kiểm tra quyền theo từng nguồn

```dart
class MediaPickerWithSourceCheck extends StatefulWidget {
  @override
  _MediaPickerWithSourceCheckState createState() => _MediaPickerWithSourceCheckState();
}

class _MediaPickerWithSourceCheckState extends State<MediaPickerWithSourceCheck> {
  late DSMediaPickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DSMediaPickerController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Camera picker
        ElevatedButton(
          onPressed: () => _openCameraPicker(),
          child: Text('Chụp ảnh'),
        ),
        
        // Gallery picker
        ElevatedButton(
          onPressed: () => _openGalleryPicker(),
          child: Text('Chọn từ thư viện'),
        ),
        
        // Mixed picker
        ElevatedButton(
          onPressed: () => _openMixedPicker(),
          child: Text('Chọn từ cả hai'),
        ),
      ],
    );
  }

  Future<void> _openCameraPicker() async {
    final hasPermission = await PermissionService.instance.requestCameraPermission(context);
    if (hasPermission) {
      // Hiển thị camera picker
      _showMediaPicker(DSMediaSource.camera);
    }
  }

  Future<void> _openGalleryPicker() async {
    final hasPermission = await PermissionService.instance.requestPhotoLibraryPermission(context);
    if (hasPermission) {
      // Hiển thị gallery picker
      _showMediaPicker(DSMediaSource.gallery);
    }
  }

  Future<void> _openMixedPicker() async {
    final permissions = <Permission>[
      Permission.camera,
      Platform.isIOS ? Permission.photos : Permission.storage,
    ];

    final results = await PermissionService.instance.requestPermissions(
      permissions,
      context,
    );

    if (results.every((granted) => granted)) {
      // Hiển thị mixed picker
      _showMediaPicker(DSMediaSource.both);
    }
  }

  void _showMediaPicker(DSMediaSource source) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Media Picker'),
        content: SizedBox(
          width: 300,
          height: 400,
          child: DSMediaPicker(
            controller: _controller,
            mediaSource: source,
            saveLocalFolder: 'source_check_media',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
```

## 🔍 Debug và Troubleshooting

### 1. Kiểm tra trạng thái quyền

```dart
Future<void> _debugPermissions() async {
  final cameraStatus = await Permission.camera.status;
  final photoStatus = Platform.isIOS 
      ? await Permission.photos.status 
      : await Permission.storage.status;

  print('Camera permission: $cameraStatus');
  print('Photo library permission: $photoStatus');
}
```

### 2. Xử lý quyền bị từ chối vĩnh viễn

```dart
Future<void> _handlePermanentlyDenied() async {
  final status = await Permission.camera.status;
  
  if (status.isPermanentlyDenied) {
    // Hiển thị dialog hướng dẫn mở settings
    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quyền bị từ chối'),
        content: Text('Quyền camera đã bị từ chối vĩnh viễn. '
            'Vui lòng mở cài đặt để cấp quyền.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Mở cài đặt'),
          ),
        ],
      ),
    );

    if (shouldOpenSettings == true) {
      await openAppSettings();
    }
  }
}
```

### 3. Log permission events

```dart
class PermissionLogger {
  static void logPermissionRequest(Permission permission) {
    print('Requesting permission: ${permission.toString()}');
  }

  static void logPermissionResult(Permission permission, PermissionStatus status) {
    print('Permission ${permission.toString()}: $status');
  }

  static void logPermissionError(Permission permission, dynamic error) {
    print('Error requesting ${permission.toString()}: $error');
  }
}
```

## 📱 Platform-specific Notes

### Android

- **Android 10+**: Không cần `WRITE_EXTERNAL_STORAGE` cho app-specific storage
- **Android 11+**: Sử dụng `MANAGE_EXTERNAL_STORAGE` cho full storage access
- **Scoped Storage**: App chỉ có thể truy cập files trong app-specific directory

### iOS

- **Limited Photos**: iOS 14+ cho phép user chọn limited photos
- **Photo Library Changes**: Cần handle `PHPhotoLibrary` changes
- **Privacy**: Tất cả permission requests phải có usage description

## 🧪 Testing

### 1. Test permission flows

```dart
void testPermissionFlows() {
  testWidgets('should request camera permission when needed', (tester) async {
    // Test implementation
  });

  testWidgets('should handle denied permissions gracefully', (tester) async {
    // Test implementation
  });

  testWidgets('should open settings when permanently denied', (tester) async {
    // Test implementation
  });
}
```

### 2. Mock permission service

```dart
class MockPermissionService extends PermissionService {
  bool _cameraGranted = false;
  bool _photoLibraryGranted = false;

  @override
  Future<bool> checkPermission(
    Permission permission,
    BuildContext context,
  ) async {
    if (permission == Permission.camera) {
      return _cameraGranted;
    }
    if (permission == Permission.photos || permission == Permission.storage) {
      return _photoLibraryGranted;
    }
    return false;
  }

  void setCameraPermission(bool granted) {
    _cameraGranted = granted;
  }

  void setPhotoLibraryPermission(bool granted) {
    _photoLibraryGranted = granted;
  }
}
```

## 📚 Resources

- [permission_handler Documentation](https://pub.dev/packages/permission_handler)
- [Flutter Permission Best Practices](https://flutter.dev/docs/deployment/android#permissions)
- [iOS Privacy Guidelines](https://developer.apple.com/app-store/review/guidelines/#privacy)
- [Android Permission Guidelines](https://developer.android.com/training/permissions/requesting)

## 🐛 Common Issues

### 1. Permission not working on Android

**Cause**: Missing permission in AndroidManifest.xml
**Solution**: Add required permissions to manifest file

### 2. Permission not working on iOS

**Cause**: Missing usage description in Info.plist
**Solution**: Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription

### 3. Permission dialog not showing

**Cause**: Permission already granted or permanently denied
**Solution**: Check permission status and handle accordingly

### 4. App crashes on permission request

**Cause**: Missing platform configuration
**Solution**: Ensure all platform-specific setup is complete
