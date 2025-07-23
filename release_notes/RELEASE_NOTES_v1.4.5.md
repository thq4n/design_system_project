# Release Notes - Version 1.4.5

**Release Date:** December 19, 2024  
**Version:** 1.4.5+20

## 🚨 Breaking Changes

### DSBottomNavigationBar - Item Count Requirement Update

**Important:** This release includes a breaking change to the `DSBottomNavigationBar` component that may affect existing implementations.

#### What Changed
- **Previous behavior**: Required an **odd number** of navigation items
- **New behavior**: Requires an **even number** of navigation items

#### Why This Change
This change was made to improve the layout and positioning of the floating button in the center of the navigation bar. An even number of items provides better visual balance and more predictable layout behavior.

#### Impact on Existing Code
If you're currently using `DSBottomNavigationBar` with an odd number of items, you'll need to either:
1. Add one more item to make it even
2. Remove one item to make it even
3. Consider using a different navigation pattern

#### Example Migration

**Before (v1.4.4 and earlier):**
```dart
AppBottomNavigationBar(
  items: [
    AppBottomNavigationBarItemData(
      title: 'Home',
      inactiveIcon: 'home_outline',
      activeIcon: 'home_bold',
    ),
    AppBottomNavigationBarItemData(
      title: 'Profile',
      inactiveIcon: 'profile_outline',
      activeIcon: 'profile_bold',
    ),
    AppBottomNavigationBarItemData(
      title: 'Settings',
      inactiveIcon: 'settings_outline',
      activeIcon: 'settings_bold',
    ),
  ], // 3 items (odd number) - ❌ Now invalid
  floatingButtonIconTitle: 'Scan QR',
)
```

**After (v1.4.5):**
```dart
AppBottomNavigationBar(
  items: [
    AppBottomNavigationBarItemData(
      title: 'Home',
      inactiveIcon: 'home_outline',
      activeIcon: 'home_bold',
    ),
    AppBottomNavigationBarItemData(
      title: 'Profile',
      inactiveIcon: 'profile_outline',
      activeIcon: 'profile_bold',
    ),
  ], // 2 items (even number) - ✅ Valid
  floatingButtonIconTitle: 'Scan QR',
)
```

## 📝 Documentation Updates

- Updated `DSBottomNavigationBar` documentation to reflect the new even number requirement
- Improved code comments and examples for better clarity
- Enhanced assertion error messages for better debugging

## 🔧 Technical Details

- Updated assertion logic in `initState()` method
- Modified documentation comments and examples
- Improved error messages for better developer experience

## 📋 Migration Checklist

- [ ] Review all `DSBottomNavigationBar` implementations in your codebase
- [ ] Update item counts to use even numbers
- [ ] Test navigation layouts and floating button positioning
- [ ] Update any related documentation or examples

## 🚀 Getting Started

To update to version 1.4.5:

1. Update your `pubspec.yaml`:
   ```yaml
   dependencies:
     design_system_project: ^1.4.5
   ```

2. Run `flutter pub get`

3. Review and update any `DSBottomNavigationBar` implementations

## 📞 Support

If you encounter any issues during migration or have questions about this breaking change, please refer to the documentation or create an issue in the project repository.

---

**Note:** This breaking change was necessary to improve the overall user experience and layout consistency of the navigation bar component. We apologize for any inconvenience this may cause and appreciate your understanding. 