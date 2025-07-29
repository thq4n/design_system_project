# Shimmer Loading Widget Usage Guide

## Overview

The Shimmer Loading widget provides a beautiful loading animation effect that can be applied to any widget to show a loading state. The shimmer effect moves across the widget with a gradient animation, creating an engaging loading experience.

## Basic Usage

### Simple Shimmer Loading

```dart
import 'package:design_system_project/design_system_project.dart';

// Wrap your content with Shimmer widget
Shimmer.withDefaultGradient(
  child: ShimmerLoading(
    isLoading: true,
    child: Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: DSColorUsages.background.primary,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
)
```

### Using Different Gradient Types

The shimmer widget provides several pre-defined gradient options:

```dart
// Default gradient (recommended)
Shimmer.withDefaultGradient(child: yourWidget)

// Light gradient for subtle effects
Shimmer.withLightGradient(child: yourWidget)

// Medium gradient for standard effects
Shimmer.withMediumGradient(child: yourWidget)

// Dark gradient for strong effects
Shimmer.withDarkGradient(child: yourWidget)

// Brand gradient using brand colors
Shimmer.withBrandGradient(child: yourWidget)

// Rainbow gradient for colorful effects
Shimmer.withRainbowGradient(child: yourWidget)

// Pulse effect
Shimmer.withPulseEffect(child: yourWidget)

// Wave effect
Shimmer.withWaveEffect(child: yourWidget)
```

## Shimmer Skeleton Types

The `ShimmerSkeleton` widget provides pre-built loading patterns for common UI elements:

### Card Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.card,
  isLoading: true,
  child: YourCardWidget(),
)
```

### List Item Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.listItem,
  isLoading: true,
  child: YourListItemWidget(),
)
```

### Avatar Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.avatar,
  isLoading: true,
  child: YourAvatarWidget(),
)
```

### Text Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.text,
  isLoading: true,
  child: YourTextWidget(),
)
```

### Button Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.button,
  isLoading: true,
  child: YourButtonWidget(),
)
```

### Chip Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.chip,
  isLoading: true,
  child: YourChipWidget(),
)
```

### Progress Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.progress,
  isLoading: true,
  child: YourProgressWidget(),
)
```

### Custom Skeleton
```dart
ShimmerSkeleton(
  type: ShimmerSkeletonType.custom,
  isLoading: true,
  child: YourCustomWidget(),
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:design_system_project/design_system_project.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Screen'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
            child: Text(_isLoading ? 'Stop' : 'Start'),
          ),
        ],
      ),
      body: Shimmer.withDefaultGradient(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Card skeleton
              ShimmerSkeleton(
                type: ShimmerSkeletonType.card,
                isLoading: _isLoading,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('Card Content'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // List items
              ...List.generate(3, (index) => 
                ShimmerSkeleton(
                  type: ShimmerSkeletonType.listItem,
                  isLoading: _isLoading,
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: DSColorUsages.background.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('List Item ${index + 1}'),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Buttons and chips
              Row(
                children: [
                  Expanded(
                    child: ShimmerSkeleton(
                      type: ShimmerSkeletonType.button,
                      isLoading: _isLoading,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: DSColorUsages.background.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Center(
                          child: Text('Button'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ShimmerSkeleton(
                    type: ShimmerSkeletonType.chip,
                    isLoading: _isLoading,
                    child: Container(
                      height: 32,
                      width: 80,
                      decoration: BoxDecoration(
                        color: DSColorUsages.background.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text('Chip'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Design System Integration

The shimmer widget is fully integrated with the design system colors:

- **Background Colors**: Uses `DSColorUsages.background.primary` and `DSColorUsages.background.secondary`
- **Gradient Colors**: Based on design system gray and brand colors
- **Consistent Styling**: Follows the design system's color palette and spacing

## Performance Considerations

- The shimmer animation is optimized for performance
- Uses `AnimationController.unbounded` for smooth animation
- Proper disposal of animation controllers to prevent memory leaks
- Efficient rebuilds using `AnimatedBuilder`

## Troubleshooting

### Animation Not Working
1. Make sure you're using the `Shimmer` widget as an ancestor of `ShimmerLoading`
2. Ensure `isLoading` is set to `true`
3. Check that the child widget has a visible background color

### Runtime Errors
The shimmer widget has been thoroughly tested and includes comprehensive error handling:
- Null safety checks for `RenderBox` operations
- Try-catch blocks for animation operations
- Fallback mechanisms for gradient transformations
- Proper animation value clamping

### Custom Gradients
If you need a custom gradient, you can create your own:

```dart
Shimmer(
  linearGradient: LinearGradient(
    colors: [
      Colors.grey[300]!,
      Colors.grey[100]!,
      Colors.grey[300]!,
    ],
    stops: const [0.1, 0.3, 0.4],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  child: ShimmerLoading(
    isLoading: true,
    child: yourWidget,
  ),
)
```

## Testing

The shimmer widget includes comprehensive tests to ensure reliability:
- Animation functionality tests
- Error handling tests
- All skeleton type tests
- Different gradient type tests
- Loading state change tests

Run tests with:
```bash
flutter test test/shimmer_animation_test.dart
```

## Best Practices

1. **Use Appropriate Skeleton Types**: Choose the skeleton type that best matches your content
2. **Consistent Loading States**: Use the same loading pattern throughout your app
3. **Performance**: Avoid using shimmer on too many widgets simultaneously
4. **Accessibility**: Ensure loading states are accessible to screen readers
5. **Design System**: Use the provided gradient options for consistency

## Recent Improvements

- **Fixed Animation Issues**: Resolved `parametric value is outside of [0, 1] range` errors
- **Enhanced Error Handling**: Added comprehensive null safety and try-catch blocks
- **Improved Performance**: Optimized animation controller usage
- **Better Design Integration**: Enhanced skeleton patterns with more realistic loading states
- **Comprehensive Testing**: Added thorough test coverage for all functionality 