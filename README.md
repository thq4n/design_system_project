# Design System Project

A comprehensive Flutter design system package that provides a complete set of UI components, styles, and assets for building consistent and beautiful Flutter applications.

**Current Version:** 1.4.5

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.4.4
```

## 🚀 Quick Start

```dart
import 'package:design_system_project/design_system_project.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DSTheme.light,
      home: MyHomePage(),
    );
  }
}
```

## 📚 Documentation

- [Catalog App](CATALOG_README.md) - Interactive component showcase
- [Quick Start Guide](QUICK_START.md) - Getting started tutorial
- [Changelog](CHANGELOG.md) - Version history and updates

## 🎨 Components

### Core Components
- **DSButton** - Versatile button component with multiple variants
- **DSInput** - Form input component with validation support
- **DSLoading** - Loading indicators and spinners
- **DSImageView** - Image display with error handling
- **DSIconButton** - Icon-based button component
- **DSRadio** - Radio button component with modern design
- **DSBasicBrandScreenForm** - Complete screen form layout solution
- **DSBottomNavigationBar** - Bottom navigation with floating button support

### Utility Widgets
- **TransparentInkWell** - Transparent touch feedback widget
- **ImageViewWrapper** - Image wrapper with presets

## 🎯 Design Tokens

### Colors
- Brand colors with primary, secondary, and accent variants
- Semantic colors for success, warning, error, and info states
- Background, surface, and border color system

### Typography
- SF Pro Display font family
- Comprehensive text style system
- Responsive font sizing

### Spacing
- Consistent spacing scale
- Margin and padding utilities

### Icons
- Iconsax icon library integration
- Multiple icon styles (Linear, Bold, Broken)
- Customizable icon sizes

## 🔧 Development

### Running the Catalog
```bash
flutter run -t lib/catalog/main.dart
```

### Running Storybook
```bash
flutter run -t lib/stories/main.dart
```

### Running Tests
```bash
flutter test
flutter analyze
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

If you encounter any issues:

1. Check the [documentation](README.md)
2. Search existing [issues](https://github.com/yourusername/design_system_project/issues)
3. Create a new [issue](https://github.com/yourusername/design_system_project/issues/new)

---

**Happy coding! 🚀**
