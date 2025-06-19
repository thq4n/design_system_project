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
      ref: main  # or any branch/tag you want to use
```

Then run:
```bash
flutter pub get
```

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
