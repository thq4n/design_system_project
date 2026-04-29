# DSMediaPicker Initial Media Feature

## Tổng quan

Tính năng `initialMedia` cho phép bạn khởi tạo `DSMediaPicker` với media có sẵn từ server hoặc từ device. Điều này rất hữu ích khi bạn muốn hiển thị media đã tồn tại (ví dụ: ảnh đã upload trước đó) trong component.

## Cách sử dụng

### 1. Khởi tạo với media từ URL (Server)

```dart
// Tạo media từ URL
final initialMedia = DSMediaPicked.fromUrl(
  key: 'existing_image_1',
  url: 'https://example.com/images/photo.jpg',
  mimetype: 'image/jpeg',
  fileSize: 1024000, // 1MB
);

// Sử dụng trong DSMediaPicker
DSMediaPicker(
  controller: mediaController,
  maxImageMedia: 1,
  initialMedia: initialMedia,
  onMediaPicked: (media) {
    print('Media picked: ${media.key}');
  },
)
```

### 2. Khởi tạo với media từ File (Device)

```dart
// Tạo media từ File
final file = File('/path/to/local/image.jpg');
final initialMedia = DSMediaPicked.fromFile(
  key: 'local_image_1',
  file: file,
  mimetype: 'image/jpeg',
  fileSize: file.lengthSync(),
);

// Sử dụng trong DSMediaPicker
DSMediaPicker(
  controller: mediaController,
  maxImageMedia: 5,
  initialMedia: initialMedia,
)
```

### 3. Cập nhật initialMedia programmatically

```dart
// Sử dụng method setInitialMedia của controller
final newMedia = DSMediaPicked.fromUrl(
  key: 'new_image_1',
  url: 'https://example.com/images/new_photo.jpg',
  mimetype: 'image/jpeg',
);

mediaController.setInitialMedia(newMedia);

// Hoặc xóa initialMedia
mediaController.setInitialMedia(null);
```

## Các trường hợp sử dụng

### 1. Single Selection (maxImageMedia = 1)

Khi `maxImageMedia = 1`, `initialMedia` sẽ thay thế hoàn toàn media hiện tại:

```dart
DSMediaPicker(
  controller: mediaController,
  maxImageMedia: 1,
  initialMedia: existingMedia, // Sẽ thay thế media hiện tại
)
```

### 2. Multiple Selection (maxImageMedia > 1)

Khi `maxImageMedia > 1`, `initialMedia` sẽ được thêm vào danh sách hiện tại:

```dart
DSMediaPicker(
  controller: mediaController,
  maxImageMedia: 5,
  initialMedia: existingMedia, // Sẽ được thêm vào danh sách
)
```

### 3. Edit Mode

Sử dụng `initialMedia` để hiển thị media hiện tại trong chế độ chỉnh sửa:

```dart
class EditProfileScreen extends StatefulWidget {
  final String? currentAvatarUrl;
  
  @override
  Widget build(BuildContext context) {
    DSMediaPicked? initialMedia;
    
    if (currentAvatarUrl != null) {
      initialMedia = DSMediaPicked.fromUrl(
        key: 'current_avatar',
        url: currentAvatarUrl!,
        mimetype: 'image/jpeg',
      );
    }
    
    return Scaffold(
      body: DSMediaPicker(
        controller: avatarController,
        maxImageMedia: 1,
        initialMedia: initialMedia,
        title: 'Chọn ảnh đại diện',
        onMediaPicked: (media) {
          // Xử lý khi chọn ảnh mới
        },
      ),
    );
  }
}
```

### 4. Preview Mode

Sử dụng `initialMedia` để hiển thị media trong chế độ xem trước:

```dart
DSMediaPicker(
  controller: previewController,
  maxImageMedia: 1,
  initialMedia: previewMedia,
  onTap: (media) {
    // Mở full screen viewer
    _showFullScreenViewer(media);
  },
)
```

## API Reference

### DSMediaPicked.fromUrl()

Tạo `DSMediaPicked` từ URL (cho media từ server).

```dart
DSMediaPicked.fromUrl({
  required String key,
  required String url,
  String? mimetype,
  int? fileSize,
})
```

**Parameters:**
- `key`: Unique identifier cho media
- `url`: URL của media
- `mimetype`: MIME type của media (optional)
- `fileSize`: Kích thước file tính bằng bytes (optional)

### DSMediaPicked.fromFile()

Tạo `DSMediaPicked` từ File (cho media từ device).

```dart
DSMediaPicked.fromFile({
  required String key,
  required File file,
  String? mimetype,
  int? fileSize,
})
```

**Parameters:**
- `key`: Unique identifier cho media
- `file`: File object
- `mimetype`: MIME type của media (optional)
- `fileSize`: Kích thước file tính bằng bytes (optional)

### DSMediaPickerController.setInitialMedia()

Cập nhật initial media programmatically.

```dart
void setInitialMedia(DSMediaPicked? media)
```

**Parameters:**
- `media`: Media mới hoặc null để xóa tất cả media

## Lưu ý quan trọng

1. **Key uniqueness**: Đảm bảo key của `initialMedia` là unique để tránh duplicate
2. **State management**: `initialMedia` sẽ được set state là `DSMediaState.complete`
3. **File cleanup**: Khi `initialMedia` bị thay thế, file cũ sẽ được xóa tự động
4. **Callback**: `onMediaPicked` sẽ được gọi khi `initialMedia` được thêm vào
5. **Widget lifecycle**: `initialMedia` sẽ được xử lý trong `initState()` và `didUpdateWidget()`

## Ví dụ hoàn chỉnh

```dart
class MediaPickerExample extends StatefulWidget {
  @override
  _MediaPickerExampleState createState() => _MediaPickerExampleState();
}

class _MediaPickerExampleState extends State<MediaPickerExample> {
  late DSMediaPickerController _mediaController;
  DSMediaPicked? _initialMedia;

  @override
  void initState() {
    super.initState();
    _mediaController = DSMediaPickerController();
    _loadInitialMedia();
  }

  Future<void> _loadInitialMedia() async {
    // Giả sử lấy media từ API
    final mediaData = await _fetchMediaFromAPI();
    
    if (mediaData != null) {
      setState(() {
        _initialMedia = DSMediaPicked.fromUrl(
          key: mediaData.id,
          url: mediaData.url,
          mimetype: mediaData.mimetype,
          fileSize: mediaData.fileSize,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Media Picker Example')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DSMediaPicker(
              controller: _mediaController,
              maxImageMedia: 1,
              initialMedia: _initialMedia,
              title: 'Chọn ảnh',
              onMediaPicked: (media) {
                print('Media picked: ${media.key}');
              },
              onMediaRemoved: (media) {
                print('Media removed: ${media.key}');
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Cập nhật initial media
                final newMedia = DSMediaPicked.fromUrl(
                  key: 'new_media_${DateTime.now().millisecondsSinceEpoch}',
                  url: 'https://example.com/new_image.jpg',
                  mimetype: 'image/jpeg',
                );
                _mediaController.setInitialMedia(newMedia);
              },
              child: Text('Cập nhật Media'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mediaController.dispose();
    super.dispose();
  }
}
```

## Testing

Xem file test `ds_media_picker_initial_media_test.dart` để biết thêm chi tiết về cách test tính năng này.
