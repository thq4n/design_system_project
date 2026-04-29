import 'package:flutter/material.dart';
import 'package:design_system_project/components/ds_media_picker/ds_media_picker.dart';

class MediaPickerTest extends StatefulWidget {
  const MediaPickerTest({super.key});

  @override
  State<MediaPickerTest> createState() => _MediaPickerTestState();
}

class _MediaPickerTestState extends State<MediaPickerTest> {
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
        title: const Text('DS Media Picker Test'),
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Photo Picker (Camera Only)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DSMediaPicker(
              controller: _controller,
              mediaType: DSMediaPickerType.photo,
              mediaSource: DSMediaSource.camera,
              maxImageMedia: 5,
              crossAxisCount: 3,
              onMediaPicked: (media) {
                // print('Single media picked: ${media.key}');
              },
              onMediaRemoved: (media) {
                // print('Single media removed: ${media.key}');
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Photo & Video Picker (Both Sources)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DSMediaPicker(
              controller: DSMediaPickerController(),
              mediaType: DSMediaPickerType.both,
              mediaSource: DSMediaSource.both,
              maxImageMedia: 3,
              maxVideoMedia: 3,
              crossAxisCount: 4,
              autoUpload: false,
            ),
            const SizedBox(height: 24),
            const Text(
              'Gallery Only Picker',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DSMediaPicker(
              controller: DSMediaPickerController(),
              mediaType: DSMediaPickerType.photo,
              mediaSource: DSMediaSource.gallery,
              maxImageMedia: 2,
              crossAxisCount: 2,
            ),
          ],
        ),
      ),
    );
  }
}
