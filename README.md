# Flutter Design System

A comprehensive Flutter design system package that provides a modular structure including reusable components, design tokens, and theming to maintain consistency and scalability across Flutter applications.

## Features

- 🎨 **Design Tokens**: Colors, typography, spacing, and other design constants
- 🧩 **Reusable Components**: Buttons, inputs, checkboxes, and more
- 🌓 **Theme Support**: Light and dark theme support
- 📦 **Asset Management**: Integrated asset management with code generation
- 🎯 **Type Safety**: Generated code for type-safe asset access

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.0.0  # Use specific version tag for stability
```

Then run:
```bash
flutter pub get
```

### Version History

| Version | Release Date | Description |
|---------|--------------|-------------|
| [v1.2.4](https://github.com/yourusername/design_system_project/releases/tag/v1.2.4) | 2024-01-XX | Image gallery and page indicator widgets |
| [v1.2.3](https://github.com/yourusername/design_system_project/releases/tag/v1.2.3) | 2024-01-XX | XXS text size and DSInput component |
| [v1.2.2](https://github.com/yourusername/design_system_project/releases/tag/v1.2.2) | 2024-01-XX | Shadow system export and import simplification |
| [v1.2.1](https://github.com/yourusername/design_system_project/releases/tag/v1.2.1) | 2024-01-XX | Code quality improvements and naming consistency |
| [v1.2.0](https://github.com/yourusername/design_system_project/releases/tag/v1.2.0) | 2024-01-XX | Shadow system and navigation utilities |
| [v1.0.0](https://github.com/yourusername/design_system_project/releases/tag/v1.0.0) | 2024-01-XX | Initial release with core components |

## Usage

### Import the package

```dart
import 'package:design_system_project/design_system_project.dart';
```

### Using Design Tokens

```dart
import 'package:design_system_project/tokens/colors.dart';
import 'package:design_system_project/tokens/typography.dart';

// Use design tokens
final primaryColor = AppColors.primary;
final headingStyle = AppTypography.heading1;
```

### Using Components

```dart
import 'package:design_system_project/components/button.dart';

// Use components
AppButton(
  onPressed: () {},
  child: Text('Click me'),
);
```

### Using Theme

```dart
import 'package:design_system_project/theme/app_theme.dart';

// Apply theme to your app
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  // ...
);
```

## Additional Information

### Assets

The package includes various assets that are automatically generated for type-safe access:

```dart
import 'package:design_system_project/gen/assets.gen.dart';

// Use generated asset references
Image.asset(Assets.images.logo.path);
```

### Fonts

The package includes the following font families:
- SF Pro Display (with all weights and styles)
- Iconsax Plus (Bold, Broken, Linear variants)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
