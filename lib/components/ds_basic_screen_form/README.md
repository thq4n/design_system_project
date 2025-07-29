# BasicScreenForm Component

A modern screen form component with blur effect app bar, similar to iOS design patterns.

## Features

- **Modern Blur Effect**: App bar with backdrop blur effect for a modern look
- **Smart Back Button**: Intelligent back button handling with proper navigation logic
- **Customizable**: Extensive customization options for colors, styling, and behavior
- **Responsive**: Automatically handles different screen sizes and orientations
- **Keyboard Aware**: Automatically dismisses keyboard when tapping outside
- **Flexible Layout**: Supports various content types with smart padding

## Usage

```dart
import 'package:design_system_project/components/ds_components.dart';

BasicScreenForm(
  title: 'My Screen',
  child: YourContentWidget(),
  actions: [
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {},
    ),
  ],
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)
```

## Key Parameters

### Required
- `title`: The title displayed in the app bar
- `child`: The main content widget

### Optional
- `enableBlur`: Enable/disable blur effect (default: true)
- `maxBlurOpacity`: Blur effect opacity (default: 0.7)
- `showBackButton`: Show/hide back button (default: true)
- `actions`: List of action widgets in app bar
- `floatingActionButton`: Floating action button
- `bottomWidget`: Widget displayed at bottom of screen
- `padding`: Custom padding for content
- `onBack`: Custom back button handler
- `result`: Result to return when back is pressed
- `popWithResult`: Whether to pop with result

## Examples

### Basic Usage
```dart
BasicScreenForm(
  title: 'Simple Form',
  child: Column(
    children: [
      Text('Your content here'),
    ],
  ),
)
```

### With Custom Styling
```dart
BasicScreenForm(
  title: 'Custom Styled',
  enableBlur: true,
  maxBlurOpacity: 0.8,
  appbarColor: DSColorUsages.background.brandSecondary,
  child: YourContent(),
)
```

### With Actions and FAB
```dart
BasicScreenForm(
  title: 'With Actions',
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  child: YourContent(),
)
```

### With Bottom Widget
```dart
BasicScreenForm(
  title: 'With Bottom Widget',
  bottomWidget: Container(
    padding: EdgeInsets.all(16),
    child: ElevatedButton(
      onPressed: () {},
      child: Text('Submit'),
    ),
  ),
  child: YourContent(),
)
```

## Design System Integration

The component integrates with the design system's:
- Color usage patterns
- Typography system
- Icon system
- Theme extensions
- State management

## Migration from DSBAsicBrandScreenForm

If you're migrating from the older `DSBAsicBrandScreenForm`, the new `BasicScreenForm` provides:
- Modern blur effect UI
- Better navigation handling
- More flexible layout options
- Improved accessibility
- Better performance 