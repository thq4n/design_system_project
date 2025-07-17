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