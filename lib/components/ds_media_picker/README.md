# DS Media Picker

A comprehensive media picker widget for Flutter applications that supports photo and video selection from camera and gallery.

## Features

- 📸 **Photo & Video Support**: Pick photos and videos from camera or gallery
- 🎯 **Multiple Sources**: Support for camera, gallery, or both
- 📱 **Permission Handling**: Automatic camera and storage permission requests
- 💾 **Local Storage**: Save picked media to local device storage
- 🔄 **Upload Integration**: Built-in upload functionality with progress tracking
- 🎨 **Customizable UI**: Configurable grid layout and styling
- 🗑️ **Media Management**: Add, remove, and manage multiple media items
- 📊 **Progress Tracking**: Visual feedback for upload and processing states
- 🖼️ **Image Resizing**: Automatic image resizing to FullHD (1920x1080) with quality control

## Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  image_picker: ^1.0.7
  image: ^4.1.7
  permission_handler: ^11.3.1
  path_provider: ^2.1.2
  mime: ^1.0.5
```

## Basic Usage

```dart
import 'package:design_system_project/components/ds_media_picker/ds_media_picker.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late DSMediaPickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DSMediaPickerController(
      onMediaPicked: (medias) {
        print('Media picked: ${medias.length} items');
      },
      onRemoveMedia: (media) {
        print('Media removed: ${media.key}');
      },
      onUploadUnstagedDone: (medias) {
        print('Upload completed: ${medias.length} items');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DSMediaPicker(
      controller: _controller,
      mediaType: DSMediaPickerType.photo,
      mediaSource: DSMediaSource.both,
      maxMedia: 5,
      crossAxisCount: 3,
      saveLocalFolder: 'my_app_media',
      autoUpload: true,
    );
  }
}
```

## Controller

### DSMediaPickerController

The controller manages the state and operations of the media picker.

```dart
final controller = DSMediaPickerController(
  medias: [], // Initial media list
  onUploadUnstagedDone: (medias) {
    // Called when upload is completed
  },
  onRemoveMedia: (media) {
    // Called when media is removed
  },
  onMediaPicked: (medias) {
    // Called when new media is picked
  },
  allowMultiple: true, // Allow multiple media selection
  genFileName: (media) {
    // Custom file name generator
    return 'custom_${DateTime.now().millisecondsSinceEpoch}';
  },
);
```

### Controller Methods

- `addAll(List<DSMediaPicked> medias)`: Add multiple media items
- `remove(DSMediaPicked media, {bool deleteOnDevice = false})`: Remove a media item
- `removeAll({bool deleteOnDevice = false})`: Remove all media items
- `uploadUnstagedMedias({String uploadFolder = 'uploads'})`: Upload unstaged media
- `isUploading`: Check if upload is in progress
- `isProcessing`: Check if any media is being processed

## Widget Properties

### Required Properties

- `controller`: The media picker controller
- `saveLocalFolder`: Folder name to save media locally

### Optional Properties

- `variant`: Design system variant (default: `DSMediaPickerVariants.primary`)
- `mediaType`: Type of media to pick (default: `DSMediaPickerType.photo`)
- `mediaSource`: Source for media selection (default: `DSMediaSource.camera`)
- `maxMedia`: Maximum number of media items (default: no limit)
- `crossAxisCount`: Number of columns in grid (default: 4)
- `autoUpload`: Auto upload picked media (default: true)
- `uploadFolder`: Upload folder name (default: 'uploads')
- `onMediaPicked`: Callback when media is picked
- `onMediaRemoved`: Callback when media is removed
- `onTap`: Callback when media is tapped
- `canBeDeleteWhen`: Function to determine if media can be deleted
- `getFileName`: Custom file name generator
- `pickDialogTitle`: Custom dialog title
- `pickDialogMessage`: Custom dialog message
- `enableImageResize`: Enable automatic image resizing to FullHD (default: true)
- `maxImageWidth`: Maximum width for image resizing (default: 1920)
- `maxImageHeight`: Maximum height for image resizing (default: 1080)
- `imageQuality`: JPEG quality for images (0-100, default: 85)

## Media Types

### DSMediaPickerType

- `photo`: Only photos
- `video`: Only videos
- `both`: Both photos and videos

### DSMediaSource

- `camera`: Only camera
- `gallery`: Only gallery
- `both`: Both camera and gallery (shows selection dialog)

## Media Model

### DSMediaPicked

```dart
class DSMediaPicked {
  final String key;                    // Unique identifier
  final File? mediaFile;               // Local file
  final String? url;                   // Remote URL
  final String? mimetype;              // MIME type
  final bool isInUploadProgress;       // Upload status
  Uint8List? videoThumbnail;           // Video thumbnail
  final int? index;                    // Display index
}
```

### Properties

- `isVideo`: Check if media is video
- `isProcessing`: Check if media is being processed
- `isLoading`: Check if media is uploading
- `isProcressing`: Check if media is in processing state
- `isEmpty`: Check if media is empty
- `fileName`: Get file name

## Image Resizing

The DSMediaPicker includes built-in image resizing functionality that automatically resizes images to FullHD resolution (1920x1080) while maintaining aspect ratio. This helps reduce file sizes and improve app performance.

### Resize Configuration

```dart
DSMediaPicker(
  controller: controller,
  enableImageResize: true,    // Enable/disable resizing
  maxImageWidth: 1920,        // Maximum width in pixels
  maxImageHeight: 1080,       // Maximum height in pixels
  imageQuality: 85,           // JPEG quality (0-100)
  // ... other properties
)
```

### How It Works

- **Automatic Resizing**: When `enableImageResize` is true, images are automatically resized during the pick process
- **Aspect Ratio Preservation**: The original aspect ratio is maintained during resizing
- **Quality Control**: You can control the JPEG compression quality (0-100)
- **Performance**: Uses image_picker's built-in parameters for efficient processing
- **Fallback**: If resizing fails, the original image is used

### Resize Examples

#### FullHD Resize (Default)
```dart
DSMediaPicker(
  controller: controller,
  enableImageResize: true,
  maxImageWidth: 1920,
  maxImageHeight: 1080,
  imageQuality: 85,
)
```

#### HD Resize
```dart
DSMediaPicker(
  controller: controller,
  enableImageResize: true,
  maxImageWidth: 1280,
  maxImageHeight: 720,
  imageQuality: 90,
)
```

#### No Resize
```dart
DSMediaPicker(
  controller: controller,
  enableImageResize: false,
)
```

## Examples

### Photo Picker (Camera Only)

```dart
DSMediaPicker(
  controller: controller,
  mediaType: DSMediaPickerType.photo,
  mediaSource: DSMediaSource.camera,
  maxMedia: 5,
  crossAxisCount: 3,
  saveLocalFolder: 'photos',
)
```

### Video Picker (Gallery Only)

```dart
DSMediaPicker(
  controller: controller,
  mediaType: DSMediaPickerType.video,
  mediaSource: DSMediaSource.gallery,
  maxMedia: 3,
  crossAxisCount: 2,
  saveLocalFolder: 'videos',
)
```

### Mixed Media Picker (Both Sources)

```dart
DSMediaPicker(
  controller: controller,
  mediaType: DSMediaPickerType.both,
  mediaSource: DSMediaSource.both,
  maxMedia: 10,
  crossAxisCount: 4,
  saveLocalFolder: 'mixed_media',
  autoUpload: false,
  onMediaPicked: (media) {
    print('Picked: ${media.fileName}');
  },
)
```

## Permissions

The widget automatically handles camera and storage permissions. Make sure to add these permissions to your app:

### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" 
    android:maxSdkVersion="28" />
```

### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos and videos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select photos and videos</string>
```

### Permission Handling

The component automatically checks and requests permissions when needed:

- **Camera Permission**: Requested when using `DSMediaSource.camera` or `DSMediaSource.both`
- **Photo Library Permission**: Requested when using `DSMediaSource.gallery` or `DSMediaSource.both`
- **Platform-specific**: Uses `Permission.photos` on iOS and `Permission.storage` on Android

For detailed permission handling guide, see [PERMISSION_GUIDE.md](./PERMISSION_GUIDE.md).

## Customization

### Custom File Name Generator

```dart
DSMediaPicker(
  controller: controller,
  getFileName: (file) {
    return 'custom_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
  },
  saveLocalFolder: 'custom_media',
)
```

### Custom Delete Condition

```dart
DSMediaPicker(
  controller: controller,
  canBeDeleteWhen: (medias) {
    return medias.length > 1; // Only allow delete if more than 1 media
  },
  saveLocalFolder: 'conditional_delete',
)
```

### Custom Upload Integration

```dart
// Override upload method in controller
controller._uploadMedia = (media, {uploadFolder}) async {
  // Your custom upload logic here
  final url = await yourUploadService.upload(media.mediaFile!);
  controller._updateMedia(media.copyWith(url: url, isInUploadProgress: false));
};
```

## Error Handling

The widget includes built-in error handling for:

- Permission denials
- File access errors
- Upload failures
- Invalid media types

Error messages are displayed via SnackBar by default.

## Performance Considerations

- Large media files are automatically compressed
- Thumbnails are generated for videos
- Local storage is used to avoid memory issues
- Upload progress is tracked to prevent duplicate uploads

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure permissions are properly configured in manifest files
2. **File Not Found**: Check if `saveLocalFolder` path is accessible
3. **Upload Fails**: Verify upload service integration
4. **Memory Issues**: Consider reducing `maxMedia` or implementing pagination

### Debug Mode

Enable debug logging by setting:

```dart
DSMediaPicker(
  controller: controller,
  // Add debug prints in callbacks
  onMediaPicked: (media) {
    print('Debug: Media picked - ${media.key}');
  },
  saveLocalFolder: 'debug_media',
)
``` 