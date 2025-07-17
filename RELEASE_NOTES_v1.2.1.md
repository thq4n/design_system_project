# Release Notes - v1.2.1

## 🎉 What's New

### 🔧 Improvements
- **Better Naming Consistency**: Đổi tên `Assets` class thành `DSAssets` để phù hợp với naming convention
- **Enhanced Exports**: Thêm `helpers.dart` export vào main design system file
- **Code Quality**: Thêm `ignore_for_file` directive cho long lines trong navigation utils
- **Generated Files**: Cập nhật generated assets file với class name mới

### 📚 Documentation
- Updated exports documentation
- Improved code quality guidelines

## 🚀 Installation

### For New Users
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.1
```

### For Existing Users
Update your `pubspec.yaml`:
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.1  # Update this line
```

Then run:
```bash
flutter pub get
```

## 🔍 What's Changed

### Breaking Changes
- **Assets Class Rename**: `Assets` → `DSAssets`
  ```dart
  // Old usage
  Assets.images.logo.path
  
  // New usage  
  DSAssets.images.logo.path
  ```

### Exports
- Added `helpers.dart` export to main design system file
- Better organization of utility exports

### Code Quality
- Improved linting compliance
- Better code formatting

## 🧪 Testing

### Manual Testing Checklist
- [x] Assets access works with new DSAssets class name
- [x] All exports function correctly
- [x] Navigation utilities work properly
- [x] No linting errors

### Automated Testing
```bash
flutter test
flutter analyze
flutter run -t lib/catalog/main.dart
```

## 📊 Technical Details

### Changes
- **Assets Class**: Renamed from `Assets` to `DSAssets`
- **Exports**: Added helpers export
- **Code Quality**: Improved linting compliance

### Migration Guide
If you're using the old `Assets` class, update your imports:

```dart
// Old
import 'package:design_system_project/gen/assets.gen.dart';
Assets.images.logo.path

// New
import 'package:design_system_project/design_system_project.dart';
DSAssets.images.logo.path
```

## 🔗 Links

- **Documentation**: [README.md](README.md)
- **Catalog**: [CATALOG_README.md](CATALOG_README.md)
- **Quick Start**: [QUICK_START.md](QUICK_START.md)
- **Changelog**: [CHANGELOG.md](CHANGELOG.md)

## 🙏 Contributors

Thanks to everyone who contributed to this release:

- Development team
- Code quality improvements

## 📞 Support

If you encounter any issues:

1. Check the [documentation](README.md)
2. Search existing [issues](https://github.com/yourusername/design_system_project/issues)
3. Create a new [issue](https://github.com/yourusername/design_system_project/issues/new)

## 🎯 Next Steps

### Upcoming Features (v1.3.0)
- 🎨 Additional component variants
- 🌓 Enhanced theme system
- 📱 Mobile-optimized features
- 🔍 Advanced customization options

### Known Issues
- None reported yet

---

**Happy coding! 🚀** 