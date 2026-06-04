# Design System Catalog & Storybook

Hệ thống catalog và storybook tự động cho Flutter Design System, giúp team dev dễ dàng xem, test và maintain các component.

## 🚀 Tính năng

### ✅ Đã hoàn thành
- [x] **Tự động sinh file demo** cho tất cả component
- [x] **Script generate catalog** tự động từ file .demo.dart
- [x] **Catalog app** với giao diện đẹp, dễ sử dụng
- [x] **Storybook app** với interactive controls
- [x] **Design tokens showcase** hiển thị colors, spacing, typography, radius
- [x] **Code examples** và documentation cho mỗi component
- [x] **Responsive design** hoạt động tốt trên mobile và web

### 🔄 Đang phát triển
- [ ] Tích hợp storybook_flutter package
- [ ] Deploy catalog lên Flutter Web
- [ ] Thêm search và filter components
- [ ] Export component documentation

## 📁 Cấu trúc thư mục

```
lib/
├── catalog/                    # Catalog app chính
│   ├── catalog_app.dart       # Main catalog app
│   ├── tokens_showcase.dart   # Design tokens display
│   ├── widget_demos.g.dart    # Auto-generated catalog data
│   └── main.dart              # Catalog app entry point
├── stories/                   # Storybook app
│   ├── storybook_app.dart     # Main storybook app
│   ├── ds_button_story.dart   # DSButton interactive story
│   └── main.dart              # Storybook app entry point
├── scripts/                   # Automation scripts
│   └── generate_catalog.dart  # Auto-generate catalog
└── components/                # Design system components
    ├── ds_button/
    │   ├── ds_button.dart     # Component implementation
    │   └── ds_button.demo.dart # Component demo
    ├── ds_loading/
    │   ├── ds_loading.dart
    │   └── ds_loading.demo.dart
    └── ds_image_view/
        ├── ds_image_view.dart
        └── ds_image_view.demo.dart
```

## 🛠️ Cách sử dụng

### 1. Chạy Catalog App

```bash
# Chạy catalog app chính
flutter run -t lib/catalog/main.dart

# Hoặc chạy từ example app
cd example
flutter run
```

### 2. Chạy Storybook App

```bash
# Chạy storybook app
flutter run -t lib/stories/main.dart
```

### 3. Tạo component mới

Khi tạo component mới, làm theo các bước sau:

1. **Tạo component** trong `lib/components/`
2. **Tạo file demo** cùng tên với hậu tố `.demo.dart`
3. **Chạy script generate** để cập nhật catalog:

```bash
dart run lib/scripts/generate_catalog.dart
```

### 4. Cập nhật catalog

```bash
# Tự động scan và generate catalog
dart run lib/scripts/generate_catalog.dart
```

## 📝 Tạo file demo cho component mới

### Template chuẩn

```dart
import 'package:flutter/material.dart';
import 'your_component.dart';

/// YourComponent Demo
/// 
/// Customization Guide:
/// - Add more examples with different props combinations
/// - Update the description text to match your use cases
/// - Add real-world usage examples
/// - Customize the code examples below
class YourComponentDemo extends StatelessWidget {
  const YourComponentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YourComponent Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            const Text(
              'YourComponent',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Component description...'),
            const SizedBox(height: 24),

            // Examples
            _buildSection('Basic Usage', 'Simple usage example', [
              YourComponent(),
            ]),

            // Code Examples
            _buildCodeSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String description, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Text('Code Examples', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildCodeExample('Basic Usage', '''YourComponent()'''),
      ],
    );
  }

  Widget _buildCodeExample(String title, String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          SelectableText(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        ],
      ),
    );
  }
}
```

## 🔧 Scripts và Automation

### Generate Catalog Script

Script `lib/scripts/generate_catalog.dart` tự động:

1. **Scan** thư mục `lib/components/` tìm file `.demo.dart`
2. **Extract** class name từ file demo
3. **Generate** file `widget_demos.g.dart` với imports và demo list
4. **Update** catalog app tự động

### Build Runner (Tương lai)

```yaml
# pubspec.yaml
dev_dependencies:
  build_runner: ^2.15.0
  catalog_generator: # Custom generator (tương lai)

# Chạy build runner
fvm dart run build_runner build
```

## 🚀 Deploy lên Web

### Deploy Catalog App

```bash
# Build web version
flutter build web -t lib/catalog/main.dart

# Deploy lên GitHub Pages hoặc Firebase Hosting
```

### Deploy Storybook App

```bash
# Build web version
flutter build web -t lib/stories/main.dart

# Deploy lên hosting service
```

## 📊 Best Practices

### 1. File Demo Structure

- **Tên file**: `component_name.demo.dart`
- **Class name**: `ComponentNameDemo`
- **Extends**: `StatelessWidget`
- **Include**: Description, examples, code samples

### 2. Component Organization

```
component_name/
├── component_name.dart      # Main component
├── component_name.demo.dart # Demo file
├── component_name_story.dart # Storybook story (optional)
└── README.md               # Component documentation
```

### 3. Naming Conventions

- **Files**: snake_case (e.g., `ds_button.dart`)
- **Classes**: PascalCase (e.g., `DSButton`)
- **Demo classes**: PascalCase + "Demo" (e.g., `DSButtonDemo`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `DEFAULT_PADDING`)

### 4. Documentation Standards

- **Component description**: Mô tả ngắn gọn chức năng
- **Props documentation**: Giải thích từng prop
- **Usage examples**: Ví dụ thực tế
- **Code samples**: Code có thể copy-paste

## 🔄 Maintenance Workflow

### Khi thêm component mới:

1. Tạo component trong `lib/components/`
2. Tạo file demo theo template
3. Chạy `dart run lib/scripts/generate_catalog.dart`
4. Test catalog app
5. Commit changes

### Khi update component:

1. Update component implementation
2. Update demo file nếu cần
3. Test catalog app
4. Commit changes

### Khi thêm story mới:

1. Tạo story file trong `lib/stories/`
2. Update `storybook_app.dart`
3. Test storybook app
4. Commit changes

## 🎯 Roadmap

### Phase 1: Core Features ✅
- [x] Basic catalog system
- [x] Demo file generation
- [x] Auto-generate script
- [x] Design tokens showcase

### Phase 2: Enhanced Features 🔄
- [ ] Advanced storybook integration
- [ ] Search and filtering
- [ ] Component documentation export
- [ ] Interactive playground

### Phase 3: Advanced Features 📋
- [ ] Component testing integration
- [ ] Accessibility testing
- [ ] Performance monitoring
- [ ] Design system analytics

### Phase 4: Enterprise Features 📋
- [ ] Multi-theme support
- [ ] Component versioning
- [ ] Design handoff integration
- [ ] Automated testing pipeline

## 🤝 Contributing

### Guidelines

1. **Follow naming conventions**
2. **Add demo file** cho component mới
3. **Update documentation** khi thay đổi API
4. **Test catalog app** trước khi commit
5. **Use conventional commits**

### Commit Message Format

```
feat: add new button variant
fix: resolve catalog generation issue
docs: update component documentation
style: improve catalog UI design
refactor: simplify demo file structure
```

## 📞 Support

- **Issues**: Tạo issue trên GitHub
- **Documentation**: Xem `CATALOG_README.md`
- **Examples**: Chạy catalog app để xem examples
- **Scripts**: Xem `lib/scripts/` folder

---

**Happy Cataloging! 🎉** 