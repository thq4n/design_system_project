# 📋 Release Checklist

## Pre-Release Checklist

### ✅ Code Quality
- [ ] Tất cả tests pass
- [ ] Code analysis không có lỗi (`flutter analyze`)
- [ ] Lint rules được tuân thủ
- [ ] Documentation được cập nhật

### ✅ Functionality
- [ ] Catalog app hoạt động bình thường
- [ ] Storybook app hoạt động bình thường
- [ ] Example app hoạt động bình thường
- [ ] Tất cả components được test

### ✅ Dependencies
- [ ] Dependencies được update lên version mới nhất (nếu cần)
- [ ] Không có security vulnerabilities
- [ ] `pubspec.lock` được commit

### ✅ Assets & Resources
- [ ] Tất cả assets được include
- [ ] Fonts được configure đúng
- [ ] Generated files được update (`flutter packages pub run build_runner build`)

## Release Process

### 1. Update Version
```bash
# Update version trong pubspec.yaml
# Format: MAJOR.MINOR.PATCH+BUILD
# Ví dụ: 1.0.0+1 → 1.1.0+2
```

### 2. Generate Assets
```bash
fvm dart run build_runner build
```

### 3. Test Everything
```bash
flutter analyze
flutter test
flutter run -t lib/catalog/main.dart
flutter run -t lib/stories/main.dart
flutter run -t example/lib/main.dart
```

### 4. Commit Changes
```bash
git add .
git commit -m "chore: prepare for release v1.1.0"
```

### 5. Create Tag
```bash
git tag -a v1.1.0 -m "Release v1.1.0"
```

### 6. Push to Remote
```bash
git push origin main
git push origin v1.1.0
```

## Post-Release Checklist

### ✅ Documentation
- [ ] Update README.md nếu cần
- [ ] Update ../CHANGELOG.md
- [ ] Update version trong example/pubspec.yaml

### ✅ Communication
- [ ] Tạo GitHub Release với release notes
- [ ] Thông báo cho team về release mới
- [ ] Update documentation nếu cần

## Version Strategy

### Semantic Versioning (SemVer)
- **MAJOR**: Breaking changes (API changes)
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)
- **BUILD**: Build number (auto-increment)

### Examples
- `1.0.0+1` → `1.0.1+2` (bug fix)
- `1.0.0+1` → `1.1.0+2` (new feature)
- `1.0.0+1` → `2.0.0+2` (breaking change)

## Branch Strategy

### Main Branch
- `master`: Production-ready code
- `develop`: Development branch
- `feature/*`: Feature branches
- `hotfix/*`: Hotfix branches

### Release Flow
1. Develop features in `feature/*` branches
2. Merge to `develop` branch
3. Test thoroughly in `develop`
4. Merge `develop` to `master` for release
5. Create tag from `master` branch 