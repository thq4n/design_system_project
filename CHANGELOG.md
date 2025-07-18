# Changelog

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