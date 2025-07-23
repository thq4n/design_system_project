# Release Notes - v1.2.6

## 🎉 What's New

### ✨ New Features
- **DSImageView Package Parameter**: Restored package parameter với default value
  - Added back package parameter với default 'design_system_project'
  - Maintains backward compatibility
  - Provides flexibility for custom package specification
  - Best of both worlds: simplicity và flexibility

### 🔧 Improvements
- **Backward Compatibility**: Restored package parameter functionality
- **Flexibility**: Allow custom package specification when needed
- **Default Behavior**: Maintains simple usage với default package

### 📚 Documentation
- Updated DSImageView usage examples
- Clarified package parameter behavior

## 🚀 Installation

### For New Users
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.6
```

### For Existing Users
Update your `pubspec.yaml`:
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.6  # Update this line
```

Then run:
```bash
flutter pub get
```

## 🔍 What's Changed

### DSImageView Component
- **Package Parameter**: Restored với default value 'design_system_project'
- **Backward Compatibility**: Previous usage patterns still work
- **Flexibility**: Can specify custom package when needed

### Usage Patterns
```dart
// Simple usage (uses default package)
DSImageView(
  imageUrl: 'assets/image.png',
);

// Custom package usage
DSImageView(
  imageUrl: 'assets/image.png',
  package: 'my_custom_package',
);

// Both patterns work seamlessly
```

## 🧪 Testing

### Manual Testing Checklist
- [x] DSImageView renders correctly với default package
- [x] Custom package specification works
- [x] Backward compatibility maintained
- [x] All existing functionality preserved

### Automated Testing
```bash
flutter test
flutter analyze
flutter run -t lib/catalog/main.dart
```

## 📊 Technical Details

### Changes
- **DSImageView**: Restored package parameter với default value
- **Backward Compatibility**: Maintained previous functionality
- **Flexibility**: Added custom package support

### Migration from v1.2.5
If you were using DSImageView in v1.2.5, no changes needed:

```dart
// v1.2.5 usage (still works in v1.2.6)
DSImageView(
  imageUrl: 'assets/image.png',
);

// v1.2.6 also supports custom package
DSImageView(
  imageUrl: 'assets/image.png',
  package: 'my_package', // Optional
);
```

## 🔗 Links

- **Documentation**: [README.md](README.md)
- **Catalog**: [CATALOG_README.md](CATALOG_README.md)
- **Quick Start**: [QUICK_START.md](QUICK_START.md)
- **Changelog**: [../CHANGELOG.md](../CHANGELOG.md)

## 🎯 Usage Examples

### DSImageView Usage
```dart
import 'package:design_system_project/design_system_project.dart';

// Basic usage (uses default package)
DSImageView(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
);

// With custom package
DSImageView(
  imageUrl: 'assets/custom_image.png',
  package: 'my_custom_package',
  width: 200,
  height: 200,
);

// With placeholder (uses default package)
DSImageView(
  imageUrl: 'https://example.com/image.jpg',
  placeHolder: 'assets/placeholder.png',
  width: 200,
  height: 200,
);

// With custom fit và package
DSImageView(
  imageUrl: 'assets/image.png',
  package: 'my_package',
  fit: BoxFit.cover,
  width: 200,
  height: 200,
);
```

## 🙏 Contributors

Thanks to everyone who contributed to this release:

- Development team
- Component flexibility improvements

## 📞 Support

If you encounter any issues:

1. Check the [documentation](README.md)
2. Search existing [issues](https://github.com/yourusername/design_system_project/issues)
3. Create a new [issue](https://github.com/yourusername/design_system_project/issues/new)

## 🎯 Next Steps

### Upcoming Features (v1.3.0)
- 🎨 Additional component improvements
- 🌓 Enhanced image handling
- 📱 Mobile-optimized features
- 🔍 Advanced customization options

### Known Issues
- None reported yet

---

**Happy coding! 🚀** 