import 'package:flutter/material.dart';
import 'package:design_system_project/components/ds_media_picker/ds_media_picker.dart';

class MediaPickerStatesDemo extends StatefulWidget {
  const MediaPickerStatesDemo({super.key});

  @override
  State<MediaPickerStatesDemo> createState() => _MediaPickerStatesDemoState();
}

class _MediaPickerStatesDemoState extends State<MediaPickerStatesDemo> {
  late DSMediaPickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DSMediaPickerController(
      onMediaPicked: (medias) {
        // print('Media picked: ${medias.length} items');
      },
      onRemoveMedia: (media) {
        // print('Media removed: ${media.key}');
      },
      onUploadUnstagedDone: (medias) {
        // print('Upload completed: ${medias.length} items');
      },
    );

    // Add some demo media with different states
    _addDemoMedia();
  }

  void _addDemoMedia() {
    // Add media with different states for demo
    final demoMedias = [
      DSMediaPicked(
        key: 'demo_complete',
        url: 'https://picsum.photos/200/300',
        mimetype: 'image/jpeg',
        state: DSMediaState.complete,
        fileSize: 1024 * 512, // 512KB
      ),
      DSMediaPicked(
        key: 'demo_error',
        url: 'https://invalid-url.com/image.jpg',
        mimetype: 'image/jpeg',
        state: DSMediaState.error,
        fileSize: 1024 * 1024, // 1MB
        errorMessage: 'Không thể tải file',
      ),
      DSMediaPicked(
        key: 'demo_inprogress',
        url: 'https://picsum.photos/200/301',
        mimetype: 'image/jpeg',
        state: DSMediaState.inProgress,
        fileSize: 1024 * 256, // 256KB
        uploadProgress: 0.6,
      ),
    ];

    _controller.addAll(demoMedias);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DS Media Picker States Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () {
              _controller.uploadUnstagedMedias();
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.removeAll();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addDemoMedia();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Media Picker với các trạng thái khác nhau',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Base: Ô vuông nét đứt màu đỏ với icon +',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              '• In Progress: Thumbnail với overlay loading và %',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              '• Complete: Thumbnail rõ nét với tên file và dung lượng',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              '• Error: Viền đỏ với thông báo lỗi',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
            DSMediaPicker(
              controller: _controller,
              mediaType: DSMediaPickerType.photo,
              mediaSource: DSMediaSource.both,
              maxMedia: 8,
              crossAxisCount: 4,
              saveLocalFolder: 'media_picker_states_demo',
              autoUpload: true,
              onMediaPicked: (media) {
                // print(
                //   'Single media picked: ${media.key} - State: ${media.state}',
                // );
              },
              onMediaRemoved: (media) {
                // print('Single media removed: ${media.key}');
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'View Mode (Chỉ xem)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DSMediaPicker(
              controller: DSMediaPickerController(
                medias: [
                  DSMediaPicked(
                    key: 'view_only',
                    url: 'https://picsum.photos/200/302',
                    mimetype: 'image/jpeg',
                    state: DSMediaState.view,
                    fileSize: 1024 * 768, // 768KB
                  ),
                ],
              ),
              mediaType: DSMediaPickerType.photo,
              mediaSource: DSMediaSource.both,
              maxMedia: 3,
              crossAxisCount: 3,
              saveLocalFolder: 'media_picker_view_demo',
              autoUpload: false,
            ),
          ],
        ),
      ),
    );
  }
}
