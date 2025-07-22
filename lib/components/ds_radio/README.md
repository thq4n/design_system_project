# DSRadio Component

A customizable radio button component that follows the design system guidelines.

## Features

- ✅ **Multiple Variants**: Primary, Secondary, Outline, and Ghost
- ✅ **Different Sizes**: Small (16px), Medium (20px), Large (24px)
- ✅ **Labels & Descriptions**: Support for text labels and descriptions
- ✅ **Custom Content**: Ability to use custom widgets as content
- ✅ **Label Positioning**: Labels can be positioned on left or right
- ✅ **Disabled State**: Proper disabled state handling
- ✅ **Accessibility**: Built-in accessibility support
- ✅ **Animations**: Smooth transitions and hover effects
- ✅ **Type Safety**: Generic type support for values

## Basic Usage

```dart
import 'package:design_system_project/components/ds_radio/ds_radio.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSRadio<int>(
          value: 1,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value ?? 1;
            });
          },
          label: 'Option 1',
        ),
        DSRadio<int>(
          value: 2,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value ?? 1;
            });
          },
          label: 'Option 2',
        ),
      ],
    );
  }
}
```

## Props

### Required Props

| Prop | Type | Description |
|------|------|-------------|
| `value` | `T` | The value represented by this radio button |
| `groupValue` | `T?` | The currently selected value for the group |
| `onChanged` | `ValueChanged<T?>?` | Callback when the radio is selected |

### Optional Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `label` | `String?` | `null` | Text label to display next to the radio |
| `description` | `String?` | `null` | Description text below the label |
| `isDisabled` | `bool` | `false` | Whether the radio is disabled |
| `size` | `DSRadioSize` | `DSRadioSize.md` | Size of the radio button |
| `variant` | `DSRadioVariant` | `DSRadioVariant.primary` | Visual variant of the radio |
| `labelOnRight` | `bool` | `true` | Whether to show label on the right |
| `child` | `Widget?` | `null` | Custom widget to display as content |

## Variants

### Primary (Default)
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Primary Radio',
  variant: DSRadioVariant.primary,
)
```

### Secondary
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Secondary Radio',
  variant: DSRadioVariant.secondary,
)
```

### Outline
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Outline Radio',
  variant: DSRadioVariant.outline,
)
```

### Ghost
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Ghost Radio',
  variant: DSRadioVariant.ghost,
)
```

## Sizes

### Small (16px)
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Small Radio',
  size: DSRadioSize.sm,
)
```

### Medium (20px) - Default
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Medium Radio',
  size: DSRadioSize.md,
)
```

### Large (24px)
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Large Radio',
  size: DSRadioSize.lg,
)
```

## Advanced Usage

### With Description
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Premium Plan',
  description: 'Best value for money with all features included',
)
```

### Custom Content
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  child: Row(
    children: [
      Icon(Icons.star, color: Colors.amber),
      SizedBox(width: 8),
      Text('Custom Content'),
    ],
  ),
)
```

### Label on Left
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  label: 'Label on Left',
  labelOnRight: false,
)
```

### Disabled State
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: null, // or provide a callback that does nothing
  label: 'Disabled Radio',
  isDisabled: true,
)
```

### Radio Only (No Label)
```dart
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
  // No label or child provided
)
```

## Accessibility

The component automatically handles:
- Screen reader announcements
- Keyboard navigation
- Focus indicators
- Semantic labels

## Theming

The radio component uses the design system's color tokens and follows the established theming patterns. Colors are automatically adapted based on:
- Selected/unselected state
- Disabled state
- Variant type
- Theme mode (light/dark)

## Demo

See `ds_radio.demo.dart` for a comprehensive showcase of all features and variants.

## Migration from Flutter's Radio

If you're migrating from Flutter's built-in `Radio` widget:

```dart
// Old Flutter Radio
Radio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
)

// New DSRadio
DSRadio<int>(
  value: 1,
  groupValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value ?? 1),
)
```

The main differences are:
- `DSRadio` instead of `Radio`
- Additional styling and theming options
- Better accessibility out of the box
- More customization options 