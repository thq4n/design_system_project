# Changelog

All notable changes to this project will be documented in this file.

## [1.4.5] - 2024-12-19

### 🚨 Breaking Changes
- **DSBottomNavigationBar**: Changed requirement from odd number of items to even number of items for proper floating button layout
  - This affects the API behavior and may require updates to existing implementations
  - Updated assertion logic and documentation to reflect the new requirement

### 📝 Documentation
- Updated DSBottomNavigationBar documentation to reflect the new even number requirement
- Improved code comments and examples for better clarity

Tất cả những thay đổi quan trọng trong dự án này sẽ được ghi lại trong file này.

Format dựa trên [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
và dự án này tuân thủ [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- TBD

### Changed
- TBD

### Deprecated
- TBD

### Removed
- TBD

### Fixed
- TBD

### Security
- TBD

## [1.4.4] - 2024-01-XX

### Added
- **DSBottomNavigationBar Component**: New bottom navigation bar with floating button support
  - Floating action button integration with proper layout
  - Customizable navigation items with active/inactive states
  - Support for odd number of items for proper floating button placement
  - Customizable colors, text styles, and icons
  - Smooth animations and transitions

- **TransparentInkWell Widget**: New utility widget for transparent touch feedback
  - Transparent splash, hover, highlight, and focus colors
  - Useful for custom touch interactions without visual feedback
  - Simplified API for common use cases

### Changed
- **DSRadio Component**: Simplified design and improved performance
  - Removed complex variants and size options for better consistency
  - Streamlined API with focus on core functionality
  - Improved gradient-based design with better visual hierarchy
  - Enhanced accessibility and touch interactions
  - Better integration with design system tokens

- **File Organization**: Improved project structure
  - Moved release notes to dedicated `release_notes/` folder
  - Better organization of documentation and release artifacts
  - Cleaner project root directory structure

- **Example App**: Updated with simplified DSRadio usage
  - Cleaner example showcasing basic radio button functionality
  - Removed complex examples for better clarity
  - Better demonstration of component capabilities

### Technical Details
- New bottom navigation component with floating button support
- Utility widget for transparent touch interactions
- DSRadio component simplification and performance improvements
- File organization improvements for better maintainability
- Example app updates with cleaner demonstrations

## [1.4.3] - 2024-01-XX

### Changed
- **DSBasicScreenForm**: Enhanced back button with proper white color
  - Better visibility and contrast against dark backgrounds
  - Improved visual consistency with design system standards
  - Enhanced accessibility for navigation elements

- **DSImageView**: Improved error handling with custom error icons
  - Replaced generic error icon with design system icon
  - Better user experience with more informative error states
  - Consistent error handling across components

- **Example App**: Simplified usage and better documentation
  - Cleaner ImageViewWrapper usage in example app
  - Better showcase of component capabilities
  - Improved examples for developers

- **File Organization**: Better code structure and organization
  - Moved ImageViewWrapper to proper location
  - Improved import structure and optimization
  - Better code organization and maintainability

### Technical Details
- UI enhancement for better visual consistency and accessibility
- Error handling improvements with custom error icons
- Example app updates with simplified usage
- File organization improvements for better maintainability

## [1.4.2] - 2024-01-XX

### Changed
- **Code Organization**: Import optimization and better structure
  - Consolidated imports into centralized constants file
  - Improved organization of constants and icons
  - Removed unused imports and improved code quality
  - Enhanced maintainability with better code structure

- **DSInput Component**: Enhanced required field handling
  - Conditional required indicator (asterisk only shows when required)
  - Better user experience with cleaner visual feedback
  - Improved validation logic for required fields

- **Constants Management**: Better organization
  - Centralized constants through single entry point
  - Better organization of icon size and type constants
  - Import simplification across the codebase

### Technical Details
- Import optimization for better maintainability
- DSInput enhancement with conditional required indicators
- Constants management improvements
- Code quality and structure improvements

## [1.4.1] - 2024-01-XX

### Added
- **DSRadio Component Enhancement**: Major redesign with comprehensive features
  - Multiple variants: Primary, Secondary, Outline, Ghost
  - Different sizes: Small (16px), Medium (20px), Large (24px)
  - Labels & descriptions support
  - Custom content with widgets
  - Label positioning (left/right)
  - Disabled state handling
  - Enhanced accessibility support
  - Smooth animations and transitions

- **Comprehensive Documentation**: Complete documentation system
  - DSRadio README with detailed usage examples
  - Interactive demo showcasing all features
  - Migration guide from Flutter's Radio widget
  - API reference with prop documentation

### Changed
- **DSRadio Component**: Complete redesign with enhanced functionality
  - Enhanced visual design with multiple variants
  - Better color integration with design system
  - Improved accessibility and user experience
  - More flexible and customizable component

- **Example App Integration**: Enhanced example app
  - Added DSRadio examples to example app
  - Added DSImageViewWrapper examples
  - Better showcase of new components

### Technical Details
- DSRadio component with 4 variants and 3 sizes
- Comprehensive documentation and demo system
- Enhanced visual design and accessibility
- Better integration with design system

## [1.4.0] - 2024-01-XX

### Added
- **DSRadio Component**: Modern radio button component with design system integration
  - Customizable radio button with smooth animations
  - Design system color integration
  - Theme system support with variants
  - Gesture-based interaction
  - Animated selection states
  - Generic type support for different value types

- **DSImageViewWrapper Component**: Convenient wrapper for DSImageView with presets
  - Avatar preset with logo placeholder
  - Item preset with full logo placeholder
  - Banner preset with full logo placeholder
  - Simplified usage for common image types
  - Consistent placeholder handling

### Changed
- **DSBasicScreenForm Improvements**: Enhanced default behavior
  - Background color now defaults to `DSColorUsages.background.secondary`
  - Better visual consistency across different themes
  - Improved code formatting with line length limits

### Technical Details
- New DSRadio component with modern design and animations
- DSImageViewWrapper with convenient presets for common use cases
- Enhanced theme system integration for new components
- Improved default values for better UX

## [1.3.1] - 2024-01-XX

### Changed
- **DSBasicScreenForm Type Safety**: Enhanced type safety and consistency
  - Changed from `TextStyle` to `DSTextStyle` for better design system integration
  - Improved default text styles using design system typography
  - Better consistency with design system standards

- **DSBasicScreenForm Default Values**: Improved default behavior
  - `hasBottomBorderRadius` now defaults to `false` for cleaner appearance
  - Title style defaults to `textTheme.lg?.semibold` with white color
  - Description style defaults to `textTheme.base?.medium` with white color
  - Better visual hierarchy and readability

- **Code Quality**: Cleaner and more maintainable code
  - Removed unused imports and variables
  - Improved code organization and readability
  - Better separation of concerns

### Technical Details
- Enhanced type safety with DSTextStyle instead of TextStyle
- Improved default behavior for better UX
- Cleaner code organization and maintainability
- Better integration with design system standards

## [1.3.0] - 2024-01-XX

### Added
- **DSBasicScreenForm Component**: Complete screen form layout solution
  - Modern Material 3 app bar with title, description, and actions
  - Automatic status bar styling and keyboard dismissal
  - Flexible layout with customizable colors and styling
  - Built-in back button with custom styling
  - Support for header images and custom extensions
  - Comprehensive theme system integration
  - Floating action button and bottom navigation support

### Component Features
- **App Bar Customization**: Full control over app bar appearance
  - Customizable title and description with flexible styling
  - Action buttons support with proper positioning
  - Optional back button with custom styling
  - Header image support with automatic status bar management
  - Rounded bottom corners with customizable border radius
  - Gradient background with optional divider

- **Layout Management**: Smart layout handling
  - Automatic keyboard dismissal on tap outside
  - Resizable body with keyboard avoidance
  - Flexible content area with proper constraints
  - Support for floating action buttons
  - Bottom navigation bar integration

- **Theme Integration**: Comprehensive theme system
  - Complete theme configuration with defaults
  - Widget parameter overrides for customization
  - Automatic fallback to system defaults
  - Smooth theme transitions with lerp support

### Technical Details
- New DSBasicScreenForm component with comprehensive screen layout
- Complete theme system integration for screen forms
- Automatic status bar styling management
- Built-in keyboard dismissal and avoidance
- Smart layout with proper constraints
- Enhanced accessibility features

## [1.2.9] - 2024-01-XX

### Added
- **DSInput Autofill Support**: Enhanced form accessibility
  - Added `autofillHints` parameter for better form autofill support
  - Improved integration with system autofill features
  - Better user experience with automatic form filling
  - Enhanced accessibility for form inputs

### Changed
- **DSInput Theme Integration**: Cleaner theme handling
  - Removed redundant `hintStyle` and `errorStyle` properties
  - Better integration with Material 3 input decoration theme
  - Cleaner API with automatic theme styling
  - Improved consistency across all input states

### Technical Details
- Added autofillHints parameter to DSInput component
- Improved form accessibility and user experience
- Better integration with system autofill features
- Cleaner API with automatic theme styling
- Enhanced form input accessibility

## [1.2.8] - 2024-01-XX

### Added
- **DSInput Component Redesign**: Complete modern Material 3 redesign
  - Modern Material 3 styling with proper input decoration theme
  - Comprehensive border states (enabled, focused, error, disabled)
  - Enhanced error display with warning icon and proper styling
  - Focus state management with ValueNotifier
  - Improved accessibility and user experience
- **Input Decoration Theme**: Comprehensive theme system
  - Proper border states for all input conditions
  - Consistent spacing and padding
  - Brand color integration for focused states
  - Error state styling with proper color usage
  - Disabled state handling
- **DSInputController**: Added `isFocused` getter for focus state management

### Changed
- **DSInput Suffix Icons**: Redesigned layout with clear button and separator
- **DSInput Prefix Icons**: Improved layout and spacing
- **Password Visibility**: Updated icons to use DSImageView
- **Icon System**: Renamed `DSSystemIconSizes` to `DSIconSizes` for consistency
- **Color Usage**: Improved implementation with proper constructor
- **API Cleanup**: Removed unused padding parameters for cleaner API

### Breaking Changes
- `DSSystemIconSizes` renamed to `DSIconSizes`
- Removed unused padding parameters from DSInput
- DSInput now uses comprehensive input decoration theme

### Technical Details
- Complete DSInput redesign with Material 3 principles
- Added comprehensive input decoration theme
- Enhanced error display with warning icon
- Added focus state management with ValueNotifier
- Improved icon system consistency
- Better encapsulation and code organization

## [1.2.7] - 2024-01-XX

### Added
- **DSImageView Package Parameter**: Made package parameter optional (nullable)
  - Package parameter is now optional for maximum flexibility
  - Maintains backward compatibility
  - Allows for cleaner API when package is not needed
  - Better null safety implementation

### Changed
- **DSInput Component**: Updated close icon to closeCircleLinear
- **Example App**: Added DSInput component showcase
- **Example App**: Updated floating action button icon to a3dCubeScanBold
- **Dependencies**: Updated to latest versions

### Technical Details
- DSImageView package parameter now optional (String?)
- DSInput close icon updated for better UX
- Example app enhanced with DSInput showcase
- Dependencies updated in pubspec.lock

## [1.2.6] - 2024-01-XX

### Added
- **DSImageView Package Parameter**: Restored package parameter với default value
  - Added back package parameter với default 'design_system_project'
  - Maintains backward compatibility
  - Provides flexibility for custom package specification

### Changed
- **DSImageView**: Restored package parameter functionality
- **Backward Compatibility**: Previous usage patterns still work
- **Flexibility**: Can specify custom package when needed

### Technical Details
- Restored package parameter với default value
- Maintained backward compatibility từ v1.2.5
- Added flexibility for custom package specification

## [1.2.5] - 2024-01-XX

### Changed
- **DSImageView**: Simplified package parameter handling
  - Removed optional package parameter
  - Set package to 'design_system_project' by default
  - Reduced component complexity

### Breaking Changes
- **DSImageView**: Package parameter removed from constructor
  - Migration: Remove package parameter from DSImageView usage
  - Package is automatically set to 'design_system_project'

### Technical Details
- Simplified DSImageView component usage
- Improved code consistency
- Reduced component complexity

## [1.2.4] - 2024-01-XX

### Added
- **Image Gallery Widget**: Complete image gallery với zoom và hero support
  - Full-screen image gallery với PageView
  - Image zoom functionality với ExtendedImage
  - Hero animations cho smooth transitions
  - Page indicator với dots navigation
- **Page Indicator Widget**: Customizable page indicator với dots_indicator package
- **Image Zoom Widget**: Image zooming functionality với pinch to zoom
- **Hero Widget**: Hero animation wrapper cho smooth transitions
- **ImageView Wrapper**: Image display wrapper với error handling
- **New Dependency**: dots_indicator ^3.0.0

### Changed
- Enhanced existing components với improvements
- Added string utilities và helper functions
- Better widget organization và exports

### Technical Details
- Added dots_indicator dependency for page indicators
- Enhanced image gallery functionality với ExtendedImage
- Improved widget exports và organization
- Added comprehensive image handling widgets

## [1.2.3] - 2024-01-XX

### Added
- **XXS Text Size**: Added xxs text size to typography system
  - Smallest text size for captions and micro text
  - Available in DSTextTheme and DSTextStyleSize
- **DSInput Component**: Complete input component with theme support
  - Text input with validation and formatting
  - Decimal and integer formatters
  - Controller pattern for state management
- **New Widgets**: Added utility widgets
  - AvailabilityWidget: Status display widget
  - BoxColor: Color display widget
  - FooterWidget: Footer component
  - TitleWidget: Title component

### Changed
- **Typography System**: Enhanced with xxs size support
- **Icon System**: Updated social icons and system icons
- **Theme Integration**: Better integration between components and theme
- **Code Quality**: Disabled unused flutter_gen integrations

### Technical Details
- Added xxs to DSTextStyleSize enum
- Updated DSTextTheme with xxs property and lerp support
- Enhanced component system with new widgets
- Improved theme system integration

## [1.2.2] - 2024-01-XX

### Added
- **Shadow System Export**: Added `ds_shadow_core.dart` export to main design system file
- **Easy Shadow Access**: Shadow tokens now accessible through main import

### Changed
- **Simplified Imports**: Reduced import complexity for shadow usage
- **Better Integration**: Shadow system better integrated with main design system

### Usage Improvement
```dart
// Before: Required separate import
import 'package:design_system_project/design_system_core/ds_shadow/ds_shadow_core.dart';

// After: Available through main import
import 'package:design_system_project/design_system_project.dart';
```

## [1.2.1] - 2024-01-XX

### Changed
- **Breaking Change**: Renamed `Assets` class to `DSAssets` for better naming consistency
- Added `helpers.dart` export to main design system file
- Improved code quality with better linting compliance

### Fixed
- Added `ignore_for_file` directive for long lines in navigation utils
- Updated generated assets file with new class name

### Migration Guide
Update your asset usage from `Assets` to `DSAssets`:
```dart
// Old
Assets.images.logo.path

// New
DSAssets.images.logo.path
```

## [1.2.0] - 2024-01-XX

### Added
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

### Changed
- Enhanced build context extensions với shadow support
- Improved helper utilities với navigation bar functions
- Better type safety cho shadow system
- Optimized exports trong design system core

### Technical Details
- Shadow system với 5 variants: subtle, light, medium, strong, intense
- Navigation bar utilities cho iOS và Android
- Enhanced build context extensions
- Improved helper utilities organization

## [1.0.0] - 2024-01-XX

### Added
- 🎨 **Design System Core**: Hệ thống design tokens hoàn chỉnh
  - Colors: Primary, secondary, neutral colors với light/dark themes
  - Typography: SF Pro Display font với đầy đủ weights và styles
  - Spacing: Consistent spacing system
  - Radius: Border radius tokens
  - Icons: Iconsax Plus font icons (Bold, Broken, Linear variants)

- 🧩 **Components**: Các component cơ bản
  - DSButton: Button component với nhiều variants và states
  - DSLoading: Loading indicator component
  - DSImageView: Image component với error handling
  - DSIconButton: Icon button component

- 📦 **Asset Management**: 
  - Auto-generated asset references với type safety
  - Font generation cho Iconsax và SF Pro Display
  - Social media icons và branding assets

- 🎯 **Catalog System**:
  - Interactive catalog app để showcase components
  - Design tokens showcase
  - Auto-generated demo system
  - Code examples cho mỗi component

- 📚 **Storybook Integration**:
  - Interactive storybook app
  - Real-time component testing
  - Props controls và state management

- 🛠️ **Development Tools**:
  - Auto-generation scripts
  - Build runner integration
  - Comprehensive documentation

### Technical Details
- Flutter SDK: >=3.6.2 <4.0.0
- Dependencies: extended_image, flutter_svg, flutter_svg_provider
- Dev Dependencies: flutter_gen, build_runner, storybook_flutter
- Supported platforms: iOS, Android, Web, Windows, macOS, Linux

### Documentation
- README.md với installation và usage guide
- CATALOG_README.md với detailed catalog documentation
- QUICK_START.md với quick setup guide
- Component-specific documentation và examples

---

## Version History

- **1.0.0**: Initial release với core design system components 