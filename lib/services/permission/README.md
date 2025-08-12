# Permission Service

Service để xử lý việc yêu cầu và kiểm tra quyền truy cập sử dụng `permission_handler`.

## Cách sử dụng

### Import

```dart
import 'package:design_system_project/services/services.dart';
```

### Kiểm tra quyền

```dart
// Kiểm tra một quyền
bool hasCameraPermission = await PermissionService.instance.checkPermission(
  Permission.camera,
  context,
);

// Kiểm tra nhiều quyền
List<bool> permissions = await PermissionService.instance.checkPermissions(
  [Permission.camera, Permission.microphone],
  context,
);
```

### Yêu cầu quyền

```dart
// Yêu cầu một quyền
bool granted = await PermissionService.instance.requestPermission(
  Permission.camera,
  context,
  showWarningDialog: true,
);

// Yêu cầu nhiều quyền
List<bool> results = await PermissionService.instance.requestPermissions(
  [Permission.camera, Permission.microphone],
  context,
);
```

### Convenience Methods

```dart
// Yêu cầu quyền camera
bool cameraGranted = await PermissionService.instance.requestCameraPermission(context);

// Yêu cầu quyền microphone
bool micGranted = await PermissionService.instance.requestMicrophonePermission(context);

// Yêu cầu quyền location
bool locationGranted = await PermissionService.instance.requestLocationPermission(context);

// Yêu cầu quyền storage
bool storageGranted = await PermissionService.instance.requestStoragePermission(context);

// Yêu cầu quyền photo library
bool photosGranted = await PermissionService.instance.requestPhotoLibraryPermission(context);

// Yêu cầu quyền notification
bool notificationGranted = await PermissionService.instance.requestNotificationPermission(context);
```

### Mở cài đặt ứng dụng

```dart
await PermissionService.instance.openAppSetting();
```

## Available Permissions

Sử dụng trực tiếp `Permission` enum từ `permission_handler`:

- `Permission.camera` - Quyền camera
- `Permission.microphone` - Quyền microphone
- `Permission.location` - Quyền location
- `Permission.locationAlways` - Quyền location always
- `Permission.locationWhenInUse` - Quyền location when in use
- `Permission.storage` - Quyền storage
- `Permission.photos` - Quyền photo library
- `Permission.notification` - Quyền notification
- `Permission.contacts` - Quyền contacts
- `Permission.calendar` - Quyền calendar
- `Permission.phone` - Quyền phone
- `Permission.sms` - Quyền SMS
- `Permission.bluetooth` - Quyền bluetooth
- `Permission.bluetoothScan` - Quyền bluetooth scan
- `Permission.bluetoothConnect` - Quyền bluetooth connect
- `Permission.bluetoothAdvertise` - Quyền bluetooth advertise
- `Permission.sensors` - Quyền sensors
- `Permission.activityRecognition` - Quyền activity recognition
- `Permission.systemAlertWindow` - Quyền system alert window

## Permission Status

Sử dụng `PermissionStatus` enum từ `permission_handler`:

```dart
PermissionStatus status = await permission.status;

if (status.isGranted) {
  // Quyền đã được cấp
} else if (status.isDenied) {
  // Quyền bị từ chối
} else if (status.isPermanentlyDenied) {
  // Quyền bị từ chối vĩnh viễn
} else if (status.isRestricted) {
  // Quyền bị hạn chế (iOS)
} else if (status.isLimited) {
  // Quyền bị giới hạn (iOS)
}
```

## Lưu ý

1. **E2E Testing**: Service sẽ trả về `false` trong môi trường E2E test
2. **iOS Location**: Có xử lý đặc biệt cho quyền location trên iOS
3. **Warning Dialog**: Tự động hiển thị dialog cảnh báo khi quyền bị từ chối vĩnh viễn
4. **Type Safety**: Sử dụng trực tiếp `Permission` enum thay vì string constants
5. **Error Handling**: Tự động handle errors và logging

## Dependencies

Đã được thêm vào `pubspec.yaml`:

```yaml
dependencies:
  permission_handler: ^12.0.1
```

## Platform Configuration

### Android

Thêm permissions vào `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

### iOS

Thêm permissions vào `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access to record audio</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show nearby places</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs location access to show nearby places</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select photos</string>
``` 