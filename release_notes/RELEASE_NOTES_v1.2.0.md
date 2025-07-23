# Release Notes - v1.2.0

## 🎉 What's New

### ✨ New Features
- 🌟 **Shadow System**: Hệ thống shadow tokens hoàn chỉnh với 5 variants
  - Subtle: Shadow nhẹ cho subtle elevation
  - Light: Shadow vừa cho light elevation  
  - Medium: Shadow trung bình cho medium elevation
  - Strong: Shadow mạnh cho strong elevation
  - Intense: Shadow rất mạnh cho intense elevation

- 🧭 **Navigation Bar Utilities**: Tiện ích quản lý system UI
  - `setNavigationBarColor()`: Tùy chỉnh màu navigation bar
  - `setLightNavigationBar()`: Navigation bar light theme
  - `setDarkNavigationBar()`: Navigation bar dark theme
  - `setTransparentNavigationBar()`: Navigation bar trong suốt
  - `setLightSystemBars()`: Cả status bar và navigation bar light
  - `setDarkSystemBars()`: Cả status bar và navigation bar dark

### 🔧 Improvements
- Enhanced build context extensions với shadow support
- Improved helper utilities với navigation bar functions
- Better type safety cho shadow system
- Optimized exports trong design system core

### 📚 Documentation
- Updated shadow system documentation
- Added navigation bar utilities examples
- Enhanced usage guides cho system UI customization

## 🚀 Installation

### For New Users
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.0
```

### For Existing Users
Update your `pubspec.yaml`:
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.0  # Update this line
```

Then run:
```bash
flutter pub get
```

## 🔍 What's Changed

### Design Tokens
- **Shadows**: 5 shadow variants với consistent elevation system
  - `DSShadows.subtle`: 0px 1px 2px rgba(0, 0, 0, 0.05)
  - `DSShadows.light`: 0px 1px 3px rgba(0, 0, 0, 0.1)
  - `DSShadows.medium`: 0px 4px 6px rgba(0, 0, 0, 0.1)
  - `DSShadows.strong`: 0px 10px 15px rgba(0, 0, 0, 0.1)
  - `DSShadows.intense`: 0px 20px 25px rgba(0, 0, 0, 0.15)

### Utilities
- **Navigation Bar Utils**: Complete system UI management
  - Color customization với animation support
  - Theme switching (light/dark/transparent)
  - Combined status bar và navigation bar control

### Core System
- Enhanced shadow system architecture
- Improved build context extensions
- Better helper utilities organization

## 🧪 Testing

### Manual Testing Checklist
- [x] Shadow system renders correctly
- [x] Navigation bar utilities work on Android/iOS
- [x] Build context extensions function properly
- [x] All existing components still work
- [x] Design tokens display correctly

### Automated Testing
```bash
flutter test
flutter analyze
flutter run -t lib/catalog/main.dart
flutter run -t lib/stories/main.dart
```

## 📊 Technical Details

### New Dependencies
- No new external dependencies
- Enhanced internal shadow system
- Improved system UI utilities

### Supported Platforms
- ✅ iOS (Navigation bar utilities)
- ✅ Android (Navigation bar utilities)
- ✅ Web (Shadow system)
- ✅ Windows (Shadow system)
- ✅ macOS (Shadow system)
- ✅ Linux (Shadow system)

### Bundle Size Impact
- **Core Package**: ~2.5MB (no change)
- **Shadow System**: +~50KB
- **Navigation Utils**: +~20KB
- **Total Increase**: ~70KB

## 🔗 Links

- **Documentation**: [README.md](README.md)
- **Catalog**: [CATALOG_README.md](CATALOG_README.md)
- **Quick Start**: [QUICK_START.md](QUICK_START.md)
- **Changelog**: [../CHANGELOG.md](../CHANGELOG.md)

## 🎯 Usage Examples

### Shadow System Usage
```dart
import 'package:design_system_project/design_system_core/ds_shadow/ds_shadow_core.dart';

// Apply shadows to containers
Container(
  decoration: BoxDecoration(
    boxShadow: [DSShadows.subtle],
  ),
  child: Text('Subtle elevation'),
);

Container(
  decoration: BoxDecoration(
    boxShadow: [DSShadows.strong],
  ),
  child: Text('Strong elevation'),
);
```

### Navigation Bar Utilities
```dart
import 'package:design_system_project/utils/navigation_bar_utils.dart';

// Set custom navigation bar color
setNavigationBarColor(Colors.blue);

// Set light theme
setLightNavigationBar();

// Set dark theme  
setDarkNavigationBar();

// Set transparent navigation bar
setTransparentNavigationBar();

// Set both status bar and navigation bar
setLightSystemBars();
setDarkSystemBars();
```

### Build Context Extensions
```dart
// Access shadows through context
final shadow = context.shadows.medium;

// Apply shadow to widget
Container(
  decoration: BoxDecoration(
    boxShadow: [shadow],
  ),
  child: YourWidget(),
);
```

## 🙏 Contributors

Thanks to everyone who contributed to this release:

- Development team
- Design team
- QA team

## 📞 Support

If you encounter any issues:

1. Check the [documentation](README.md)
2. Search existing [issues](https://github.com/yourusername/design_system_project/issues)
3. Create a new [issue](https://github.com/yourusername/design_system_project/issues/new)

## 🎯 Next Steps

### Upcoming Features (v1.3.0)
- 🎨 Additional shadow variants
- 🌓 Enhanced theme system với shadow integration
- 📱 Mobile-optimized navigation utilities
- 🔍 Advanced shadow customization options

### Known Issues
- None reported yet

---

**Happy coding! 🚀** 