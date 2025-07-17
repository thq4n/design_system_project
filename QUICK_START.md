# 🚀 Quick Start - Design System Catalog

Hướng dẫn nhanh để chạy và test hệ thống catalog đã được xây dựng.

## ⚡ Chạy nhanh

### 1. Chạy Catalog App

```bash
# Chạy catalog app chính
flutter run -t lib/catalog/main.dart
```

### 2. Chạy Storybook App

```bash
# Chạy storybook app
flutter run -t lib/stories/main.dart
```

### 3. Test Script Generate

```bash
# Test script tự động generate catalog
dart run lib/scripts/generate_catalog.dart
```

## 📱 Tính năng đã hoàn thành

### ✅ Catalog App (`lib/catalog/main.dart`)
- **Design Tokens Showcase**: Colors, spacing, typography, radius
- **Component Demos**: DSButton, Loading, ImageView
- **Interactive UI**: Tap để xem chi tiết từng component
- **Code Examples**: Copy-paste ready code samples

### ✅ Storybook App (`lib/stories/main.dart`)
- **Interactive Stories**: DSButton với controls
- **Real-time Testing**: Thay đổi props và xem kết quả
- **Component Showcase**: Tất cả variants và states

### ✅ Auto-Generation Script
- **Scan Components**: Tự động tìm file `.demo.dart`
- **Generate Catalog**: Tạo `widget_demos.g.dart`
- **Update Automatically**: Khi thêm component mới

## 🎯 Test Cases

### Test 1: Catalog Navigation
1. Chạy `flutter run -t lib/catalog/main.dart`
2. Tap "Design Tokens" → Xem colors, spacing, typography
3. Tap "DSButton" → Xem button demos với code examples
4. Tap "Loading" → Xem loading component demos
5. Tap "ImageView" → Xem image component demos

### Test 2: Storybook Interaction
1. Chạy `flutter run -t lib/stories/main.dart`
2. Tap "DSButton Story"
3. Thay đổi các controls (Label, Variant, Size, etc.)
4. Xem button thay đổi real-time
5. Test các states khác nhau

### Test 3: Auto-Generation
1. Chạy `dart run lib/scripts/generate_catalog.dart`
2. Kiểm tra output: "Found 3 demo files"
3. Mở `lib/catalog/widget_demos.g.dart` xem code generated
4. Thêm component mới và chạy lại script

## 🔧 Thêm Component Mới

### Bước 1: Tạo Component
```dart
// lib/components/ds_card/ds_card.dart
class DSCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  
  const DSCard({super.key, required this.child, this.backgroundColor});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: child,
    );
  }
}
```

### Bước 2: Tạo Demo File
```dart
// lib/components/ds_card/ds_card.demo.dart
import 'package:flutter/material.dart';
import 'ds_card.dart';

class DSCardDemo extends StatelessWidget {
  const DSCardDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DSCard Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('DSCard Component', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DSCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Basic Card'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Bước 3: Generate Catalog
```bash
dart run lib/scripts/generate_catalog.dart
```

### Bước 4: Test
```bash
flutter run -t lib/catalog/main.dart
# Xem DSCard xuất hiện trong catalog
```

## 📊 Kết quả mong đợi

### Catalog App
- ✅ Hiển thị 4 items: Design Tokens + 3 Components
- ✅ Tap vào item mở detail page
- ✅ Design Tokens hiển thị colors, spacing, typography, radius
- ✅ Component demos có code examples

### Storybook App
- ✅ Hiển thị DSButton Story
- ✅ Interactive controls hoạt động
- ✅ Real-time preview thay đổi

### Auto-Generation
- ✅ Script scan được 3 demo files
- ✅ Generate file `widget_demos.g.dart`
- ✅ Catalog app load được tất cả demos

## 🐛 Troubleshooting

### Lỗi thường gặp

1. **"Target of URI doesn't exist"**
   ```bash
   flutter pub get
   ```

2. **"No .demo.dart files found"**
   - Kiểm tra file demo có đúng tên không
   - Chạy từ thư mục root của project

3. **Catalog không update**
   ```bash
   dart run lib/scripts/generate_catalog.dart
   flutter clean
   flutter pub get
   ```

4. **Storybook không chạy**
   - Kiểm tra `storybook_flutter` dependency
   - Chạy `flutter pub get`

## 🎉 Success!

Nếu tất cả test cases pass, bạn đã có:
- ✅ Hệ thống catalog tự động hoàn chỉnh
- ✅ Storybook với interactive controls
- ✅ Design tokens showcase
- ✅ Auto-generation script
- ✅ Documentation và code examples

**Happy Cataloging! 🚀** 