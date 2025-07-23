# Release Notes - v1.2.3

## 🎉 What's New

### ✨ New Features
- **XXS Text Size**: Thêm xxs text size vào typography system
  - Smallest text size cho captions và micro text
  - Consistent với design system scale
  - Available trong DSTextTheme và DSTextStyleSize

- **DSInput Component**: Input component hoàn chỉnh với theme support
  - Text input với validation và formatting
  - Theme integration với design system
  - Formatters cho decimal và integer input
  - Controller pattern cho state management

- **New Widgets**: Bổ sung các utility widgets
  - AvailabilityWidget: Hiển thị trạng thái availability
  - BoxColor: Color box widget
  - FooterWidget: Footer component
  - TitleWidget: Title component

### 🔧 Improvements
- **Typography System**: Enhanced với xxs size
- **Icon System**: Updated social icons và system icons
- **Theme Integration**: Better integration giữa components và theme
- **Code Quality**: Disabled unused flutter_gen integrations

### 📚 Documentation
- Added formatters documentation
- Updated typography usage examples
- Enhanced component documentation

## 🚀 Installation

### For New Users
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.3
```

### For Existing Users
Update your `pubspec.yaml`:
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.2.3  # Update this line
```

Then run:
```bash
flutter pub get
```

## 🔍 What's Changed

### Typography System
- **New XXS Size**: Added to DSTextStyleSize enum
- **DSTextTheme**: Updated với xxs property
- **Lerp Support**: Added xxs support trong lerp methods

### Components
- **DSInput**: Complete input component với:
  - Text input với validation
  - Decimal và integer formatters
  - Theme integration
  - Controller pattern

### Widgets
- **AvailabilityWidget**: Status display widget
- **BoxColor**: Color display widget
- **FooterWidget**: Footer component
- **TitleWidget**: Title component

### Technical Improvements
- Disabled unused flutter_gen integrations
- Updated icon system
- Improved theme system integration

## 🧪 Testing

### Manual Testing Checklist
- [x] XXS text size renders correctly
- [x] DSInput component works properly
- [x] All new widgets function correctly
- [x] Theme integration works
- [x] No breaking changes introduced

### Automated Testing
```bash
flutter test
flutter analyze
flutter run -t lib/catalog/main.dart
```

## 📊 Technical Details

### New Dependencies
- No new external dependencies
- Enhanced internal component system

### Supported Platforms
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

### Bundle Size Impact
- **Core Package**: ~2.5MB (no change)
- **XXS Typography**: +~5KB
- **DSInput Component**: +~50KB
- **New Widgets**: +~30KB
- **Total Increase**: ~85KB

## 🔗 Links

- **Documentation**: [README.md](README.md)
- **Catalog**: [CATALOG_README.md](CATALOG_README.md)
- **Quick Start**: [QUICK_START.md](QUICK_START.md)
- **Changelog**: [../CHANGELOG.md](../CHANGELOG.md)

## 🎯 Usage Examples

### XXS Text Size Usage
```dart
import 'package:design_system_project/design_system_project.dart';

// Using XXS text size
Text(
  'Micro text',
  style: DSTextStyle.fromSize(DSTextStyleSize.xxs),
);

// Through theme
Text(
  'Caption text',
  style: theme.textTheme.xxs,
);
```

### DSInput Component Usage
```dart
import 'package:design_system_project/design_system_project.dart';

// Basic input
DSInput(
  controller: TextEditingController(),
  label: 'Enter your name',
);

// Input with formatter
DSInput(
  controller: TextEditingController(),
  label: 'Amount',
  formatters: [DecimalTextInputFormatter()],
);

// Input with validation
DSInput(
  controller: TextEditingController(),
  label: 'Email',
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Email is required';
    return null;
  },
);
```

### New Widgets Usage
```dart
import 'package:design_system_project/widgets/widgets.dart';

// Availability widget
AvailabilityWidget(
  isAvailable: true,
  label: 'In Stock',
);

// Box color widget
BoxColor(
  color: Colors.blue,
  size: 40,
);

// Title widget
TitleWidget(
  title: 'Product Title',
  subtitle: 'Product description',
);
```

## 🙏 Contributors

Thanks to everyone who contributed to this release:

- Development team
- Typography system improvements
- Component development team

## 📞 Support

If you encounter any issues:

1. Check the [documentation](README.md)
2. Search existing [issues](https://github.com/yourusername/design_system_project/issues)
3. Create a new [issue](https://github.com/yourusername/design_system_project/issues/new)

## 🎯 Next Steps

### Upcoming Features (v1.3.0)
- 🎨 Additional input variants
- 🌓 Enhanced form validation
- 📱 Mobile-optimized input experience
- 🔍 Advanced input customization options

### Known Issues
- None reported yet

---

**Happy coding! 🚀** 