# Release Notes - v1.4.0

## 🎉 What's New

### ✨ New Components
- **DSRadio Component**: Modern radio button component with design system integration
  - Customizable radio button with smooth animations
  - Design system color integration
  - Theme system support with variants
  - Gesture-based interaction
  - Animated selection states

- **DSImageViewWrapper Component**: Convenient wrapper for DSImageView with presets
  - Avatar preset with logo placeholder
  - Item preset with full logo placeholder
  - Banner preset with full logo placeholder
  - Simplified usage for common image types
  - Consistent placeholder handling

### 🎨 Component Enhancements
- **DSBasicScreenForm Improvements**: Enhanced default behavior
  - Background color now defaults to `DSColorUsages.background.secondary`
  - Better visual consistency across different themes
  - Improved code formatting with line length limits

### 🔧 Theme System
- **DSRadio Theme Integration**: Complete theme system support
  - Theme extension for DSRadio component
  - Variant support (primary, secondary, outline, ghost)
  - Consistent theming with other components
  - Future-ready theme customization

## 🚀 Installation

### For New Users
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.4.0
```

### For Existing Users
Update your `pubspec.yaml`:
```yaml
dependencies:
  design_system_project:
    git:
      url: https://github.com/yourusername/design_system_project.git
      ref: v1.4.0  # Update this line
```

Then run:
```bash
flutter pub get
```

## 🔍 What's Changed

### DSRadio Component - Modern Radio Button
- **Custom Design**: Modern circular radio button design
- **Smooth Animations**: 200ms animated transitions
- **Design System Colors**: Integrated with design system color palette
- **Gesture Support**: Tap gesture for selection
- **Theme Integration**: Full theme system support
- **Type Safety**: Generic type support for different value types

### DSImageViewWrapper - Convenient Image Presets
- **Avatar Preset**: For profile pictures and small images
- **Item Preset**: For product images and medium-sized content
- **Banner Preset**: For large banner images
- **Consistent Placeholders**: Proper placeholder handling for each preset
- **Simplified Usage**: Easy-to-use constructors for common use cases

### DSBasicScreenForm - Enhanced Defaults
- **Background Color**: Now defaults to secondary background for better contrast
- **Code Quality**: Improved code formatting and organization
- **Visual Consistency**: Better consistency across different themes

## 🧪 Testing

### Manual Testing Checklist
- [x] DSRadio component renders correctly
- [x] DSRadio selection and deselection works
- [x] DSRadio animations are smooth
- [x] DSImageViewWrapper presets work correctly
- [x] DSImageViewWrapper placeholders display properly
- [x] DSBasicScreenForm new background defaults work
- [x] All existing functionality remains intact
- [x] Theme system integration works correctly

### Automated Testing
```bash
flutter test
flutter analyze
flutter run -t lib/catalog/main.dart
```

## 📊 Technical Details

### Major Features
- **DSRadio Component**: Modern radio button with design system integration
- **DSImageViewWrapper**: Convenient image presets with placeholders
- **Enhanced Theme System**: Better theme integration for new components
- **Improved Defaults**: Better default values for existing components

### Improvements
- **Component Variety**: More components for different use cases
- **User Experience**: Better default values and presets
- **Developer Experience**: Easier to use with convenient wrappers
- **Design System Integration**: Better integration with design system

### Usage Examples

### DSRadio Component - Basic Usage
```dart
import 'package:design_system_project/design_system_project.dart';

class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DSRadio<String>(
              value: 'option1',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            const SizedBox(width: 8),
            Text('Option 1', style: textTheme.base?.regular),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DSRadio<String>(
              value: 'option2',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            const SizedBox(width: 8),
            Text('Option 2', style: textTheme.base?.regular),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DSRadio<String>(
              value: 'option3',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            const SizedBox(width: 8),
            Text('Option 3', style: textTheme.base?.regular),
          ],
        ),
      ],
    );
  }
}
```

### DSRadio Component - Custom Types
```dart
enum UserRole { admin, user, guest }

class UserRoleSelector extends StatefulWidget {
  @override
  _UserRoleSelectorState createState() => _UserRoleSelectorState();
}

class _UserRoleSelectorState extends State<UserRoleSelector> {
  UserRole? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select User Role',
          style: textTheme.lg?.bold,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DSRadio<UserRole>(
              value: UserRole.admin,
              groupValue: selectedRole,
              onChanged: (role) {
                setState(() {
                  selectedRole = role;
                });
              },
            ),
            const SizedBox(width: 8),
            Text('Administrator', style: textTheme.base?.regular),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            DSRadio<UserRole>(
              value: UserRole.user,
              groupValue: selectedRole,
              onChanged: (role) {
                setState(() {
                  selectedRole = role;
                });
              },
            ),
            const SizedBox(width: 8),
            Text('Regular User', style: textTheme.base?.regular),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            DSRadio<UserRole>(
              value: UserRole.guest,
              groupValue: selectedRole,
              onChanged: (role) {
                setState(() {
                  selectedRole = role;
                });
              },
            ),
            const SizedBox(width: 8),
            Text('Guest User', style: textTheme.base?.regular),
          ],
        ),
      ],
    );
  }
}
```

### DSImageViewWrapper - Avatar Usage
```dart
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar with placeholder
        DSImageViewWrapper.avatar(
          'https://example.com/user-avatar.jpg',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        Text(
          'User Profile',
          style: textTheme.lg?.bold,
        ),
      ],
    );
  }
}
```

### DSImageViewWrapper - Item Usage
```dart
class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with placeholder
          DSImageViewWrapper.item(
            'https://example.com/product-image.jpg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: textTheme.base?.bold,
                ),
                const SizedBox(height: 8),
                Text(
                  'Product description goes here',
                  style: textTheme.sm?.regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### DSImageViewWrapper - Banner Usage
```dart
class BannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: DSImageViewWrapper.banner(
        'https://example.com/banner-image.jpg',
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
```

### DSBasicScreenForm - Enhanced Defaults
```dart
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'Settings',
      description: 'Manage your preferences',
      showBackButton: true,
      // Background now defaults to secondary for better contrast
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Account Settings',
              style: textTheme.lg?.bold,
            ),
            const SizedBox(height: 24),
            // Your settings content here
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: DSColorUsages.background.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Preferences',
                    style: textTheme.base?.bold,
                  ),
                  const SizedBox(height: 16),
                  // Radio buttons for notification settings
                  Row(
                    children: [
                      DSRadio<bool>(
                        value: true,
                        groupValue: true, // Replace with actual state
                        onChanged: (value) {
                          // Handle notification setting change
                        },
                      ),
                      const SizedBox(width: 8),
                      Text('Enable Notifications', style: textTheme.base?.regular),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      DSRadio<bool>(
                        value: false,
                        groupValue: true, // Replace with actual state
                        onChanged: (value) {
                          // Handle notification setting change
                        },
                      ),
                      const SizedBox(width: 8),
                      Text('Disable Notifications', style: textTheme.base?.regular),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔗 Links

- **Documentation**: [README.md](README.md)
- **Catalog**: [CATALOG_README.md](CATALOG_README.md)
- **Quick Start**: [QUICK_START.md](QUICK_START.md)
- **Changelog**: [CHANGELOG.md](CHANGELOG.md)

## 🙏 Contributors

Thanks to everyone who contributed to this release:

- Development team
- DSRadio component implementation
- DSImageViewWrapper presets
- Theme system enhancements
- Component improvements and optimizations

## 📞 Support

If you encounter any issues:

1. Check the [documentation](README.md)
2. Search existing [issues](https://github.com/yourusername/design_system_project/issues)
3. Create a new [issue](https://github.com/yourusername/design_system_project/issues/new)

## 🎯 Next Steps

### Upcoming Features (v1.5.0)
- 🎨 Additional Material 3 components
- 🌓 Enhanced theme system with more variants
- 📱 Mobile-optimized features
- 🔍 Advanced customization options
- ♿ Enhanced accessibility features
- 📊 Data visualization components
- 🎯 Form validation components
- 🔔 Notification components

### Known Issues
- None reported yet

---

**Happy coding! 🚀** 