# DS Media Picker - States Implementation

## Tổng quan

DS Media Picker đã được cập nhật để hỗ trợ đầy đủ các trạng thái UI/UX theo specification:

## Các trạng thái được hỗ trợ

### 1. Base State
- **UI**: Ô vuông nét đứt màu đỏ (#FB4B53) với icon `DSAssets.vuesax.addCircleLinear`
- **UX**: Click để chọn ảnh hoặc drag & drop
- **Vị trí**: Chờ thêm ảnh mới

### 2. In Progress State
- **UI**: 
  - Thumbnail ảnh phủ lớp mờ (overlay bán trong suốt)
  - Text "Đang tải..." 
  - Progress indicator: Vòng tròn loading
  - Hiển thị % hoàn thành
  - Tên file dưới ảnh
  - Nút `x` góc trên phải để hủy
- **UX**: 
  - Vừa thấy ảnh vừa biết đang tải
  - Có thể hủy ngay nếu chọn nhầm
  - Nếu lỗi khi tải → chuyển sang trạng thái Error

### 3. Complete State
- **UI**: 
  - Thumbnail ảnh rõ nét
  - Tên file + dung lượng dưới ảnh
  - Nút `x` để xóa
- **UX**: 
  - Xác nhận tải thành công
  - Cho phép xóa hoặc click ảnh để phóng to

### 4. Error State
- **UI**: 
  - Viền đỏ quanh thumbnail
  - Icon file lỗi với overlay cảnh báo
  - Tên file + dung lượng màu đỏ
  - Thông báo lỗi cụ thể
- **UX**: 
  - Cho biết lỗi (VD: vượt dung lượng, định dạng sai)
  - Người dùng dễ xóa để thay thế

### 5. View State
- **UI**: 
  - Thumbnail ảnh rõ, không có nút `x` hoặc progress
  - Không có overlay
- **UX**: 
  - Chỉ cho phép xem, không chỉnh sửa
  - Thích hợp cho chế độ review hoặc gallery

## Cách sử dụng

### Khởi tạo với trạng thái cụ thể

```dart
DSMediaPicked(
  key: 'unique_key',
  url: 'https://example.com/image.jpg',
  mimetype: 'image/jpeg',
  state: DSMediaState.complete, // Chỉ định trạng thái
  fileSize: 1024 * 512, // Dung lượng file (bytes)
  uploadProgress: 0.8, // Tiến độ upload (0.0 - 1.0)
  errorMessage: 'Lỗi cụ thể', // Thông báo lỗi
)
```

### Helper methods

```dart
// Kiểm tra trạng thái
media.isBaseState      // Trạng thái cơ bản
media.isInProgressState // Đang upload
media.isCompleteState   // Hoàn thành
media.isErrorState      // Lỗi
media.isViewState       // Chỉ xem

// Format thông tin
media.formattedFileSize    // "512.0 KB"
media.progressPercentage   // "80%"
```

### Controller methods

```dart
// Upload với progress tracking
await controller.uploadUnstagedMedias();

// Cập nhật trạng thái thủ công
controller._updateMedia(media.copyWith(
  state: DSMediaState.error,
  errorMessage: 'Lỗi network',
));
```

## Demo

Chạy `example/lib/media_picker_states_demo.dart` để xem demo đầy đủ các trạng thái:

```bash
cd example
flutter run
```

## Lưu ý UX chung

1. **Progress bar**: Vòng tròn loading kết hợp overlay chữ "Đang tải..."
2. **Tên file**: Luôn rút gọn hợp lý, hiển thị phần mở rộng
3. **Error state**: Luôn có tooltip hoặc thông báo lý do
4. **Drag & drop**: Hỗ trợ ở trạng thái Base
5. **Click để preview**: Áp dụng cho trạng thái Complete và View

## Migration từ version cũ

- Thêm `state` parameter vào `DSMediaPicked`
- Sử dụng helper methods thay vì logic cũ
- Cập nhật UI để sử dụng các overlay mới
- Thêm `fileSize` và `uploadProgress` cho tracking tốt hơn
