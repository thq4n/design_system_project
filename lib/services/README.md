# Services Architecture

Cấu trúc services được tổ chức theo module để dễ dàng mở rộng và quản lý.

## 📁 Cấu trúc thư mục

```
lib/services/
├── base/                          # Base classes và interfaces
│   ├── base_service.dart          # Base class cho tất cả services
│   └── index.dart                 # Export base services
├── permission/                    # Permission service module
│   ├── permission_service.dart    # Main permission service
│   ├── permission_constants.dart  # Permission constants
│   ├── permission_status.dart     # Permission status enum
│   ├── permission_service_demo.dart # Demo widget
│   └── index.dart                 # Export permission module
├── network/                       # Network service module
│   └── index.dart                 # Export network module
├── storage/                       # Storage service module
│   └── index.dart                 # Export storage module
├── analytics/                     # Analytics service module
│   └── index.dart                 # Export analytics module
├── auth/                          # Authentication service module
│   └── index.dart                 # Export auth module
├── service_manager.dart           # Service manager
├── services.dart                  # Main export file
└── README.md                     # This file
```

## 🚀 Cách sử dụng

### Import services

```dart
// Import tất cả services
import 'package:design_system_project/services/services.dart';

// Hoặc import từng module
import 'package:design_system_project/services/permission/index.dart';
import 'package:design_system_project/services/network/index.dart';
```

### Sử dụng Service Manager

```dart
// Đăng ký services
final serviceManager = ServiceManager();
serviceManager.registerService(PermissionService.instance);

// Khởi tạo tất cả services
await serviceManager.initializeAll();

// Lấy service
final permissionService = serviceManager.getService<PermissionService>();

// Dispose tất cả services
await serviceManager.disposeAll();
```

### Sử dụng Permission Service

```dart
// Kiểm tra quyền
bool hasPermission = await PermissionService.instance.checkPermission(
  PermissionConstants.camera,
  context,
);

// Yêu cầu quyền
bool granted = await PermissionService.instance.requestCameraPermission(context);
```

## 📋 Các Service Modules

### 1. Permission Service
- **File**: `permission/permission_service.dart`
- **Mô tả**: Xử lý việc yêu cầu và kiểm tra quyền truy cập
- **Features**:
  - Kiểm tra trạng thái quyền
  - Yêu cầu quyền với dialog cảnh báo
  - Xử lý đặc biệt cho iOS location
  - Convenience methods cho từng loại quyền

### 2. Network Service (Planned)
- **File**: `network/network_service.dart`
- **Mô tả**: Xử lý các request network, caching, và error handling
- **Features** (planned):
  - HTTP client với interceptors
  - Request/response caching
  - Error handling và retry logic
  - Offline support

### 3. Storage Service (Planned)
- **File**: `storage/storage_service.dart`
- **Mô tả**: Xử lý local storage, preferences, và file management
- **Features** (planned):
  - SharedPreferences wrapper
  - File storage utilities
  - Database operations
  - Secure storage

### 4. Analytics Service (Planned)
- **File**: `analytics/analytics_service.dart`
- **Mô tả**: Tracking user behavior và app metrics
- **Features** (planned):
  - Event tracking
  - User properties
  - Screen tracking
  - Crash reporting

### 5. Auth Service (Planned)
- **File**: `auth/auth_service.dart`
- **Mô tả**: Xử lý authentication và authorization
- **Features** (planned):
  - Login/logout
  - Token management
  - User session
  - Biometric authentication

## 🔧 Base Service

Tất cả services đều kế thừa từ `BaseService` để có:
- **Lifecycle management**: `initialize()`, `dispose()`
- **Consistent logging**: `logInfo()`, `logWarning()`, `handleError()`
- **Service status**: `isInitialized`, `serviceName`

## 📝 Thêm Service Mới

### 1. Tạo module folder
```bash
mkdir lib/services/your_service/
```

### 2. Tạo service class
```dart
// lib/services/your_service/your_service.dart
import '../base/base_service.dart';

class YourService extends BaseService {
  YourService._();
  static final YourService instance = YourService._();
  
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    // Implementation
  }

  @override
  Future<void> dispose() async {
    // Implementation
  }

  @override
  bool get isInitialized => _initialized;

  @override
  String get serviceName => 'YourService';
}
```

### 3. Tạo index file
```dart
// lib/services/your_service/index.dart
export 'your_service.dart';
```

### 4. Cập nhật main export
```dart
// lib/services/services.dart
export 'your_service/index.dart';
```

## 🎯 Best Practices

1. **Singleton Pattern**: Mỗi service nên là singleton
2. **Dependency Injection**: Sử dụng ServiceManager để quản lý dependencies
3. **Error Handling**: Luôn handle errors trong services
4. **Logging**: Sử dụng logging methods từ BaseService
5. **Lifecycle**: Implement initialize() và dispose() properly
6. **Testing**: Viết unit tests cho mỗi service
7. **Documentation**: Comment đầy đủ cho public APIs

## 🔄 Migration từ cấu trúc cũ

Nếu bạn đang sử dụng cấu trúc cũ, cập nhật imports:

```dart
// Cũ
import 'package:design_system_project/services/permission_service.dart';

// Mới
import 'package:design_system_project/services/services.dart';
// hoặc
import 'package:design_system_project/services/permission/index.dart';
``` 