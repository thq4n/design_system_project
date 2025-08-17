import 'dart:io';

import 'package:flutter/material.dart';
import 'package:design_system_project/components/ds_media_picker/ds_media_picker.dart';

class InitialMediaExample extends StatefulWidget {
  const InitialMediaExample({super.key});

  @override
  State<InitialMediaExample> createState() => _InitialMediaExampleState();
}

class _InitialMediaExampleState extends State<InitialMediaExample> {
  late DSMediaPickerController _singleMediaController;
  late DSMediaPickerController _multipleMediaController;
  late DSMediaPickerController _editModeController;
  
  DSMediaPicked? _initialMedia;

  @override
  void initState() {
    super.initState();
    _singleMediaController = DSMediaPickerController();
    _multipleMediaController = DSMediaPickerController(allowMultiple: true);
    _editModeController = DSMediaPickerController();
    
    // Tạo initial media từ URL (simulate data từ server)
    _initialMedia = DSMediaPicked.fromUrl(
      key: 'existing_avatar_1',
      url: 'https://picsum.photos/200/200?random=1',
      mimetype: 'image/jpeg',
      fileSize: 1024000, // 1MB
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Media Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Single Selection với Initial Media'),
            const SizedBox(height: 8),
            DSMediaPicker(
              controller: _singleMediaController,
              maxMedia: 1,
              initialMedia: _initialMedia,
              title: 'Chọn ảnh đại diện',
              onMediaPicked: (media) {
                print('Single media picked: ${media.key}');
              },
              onMediaRemoved: (media) {
                print('Single media removed: ${media.key}');
              },
            ),
            
            const SizedBox(height: 32),
            
            _buildSectionTitle('2. Multiple Selection với Initial Media'),
            const SizedBox(height: 8),
            DSMediaPicker(
              controller: _multipleMediaController,
              maxMedia: 5,
              crossAxisCount: 3,
              initialMedia: _initialMedia,
              title: 'Thêm ảnh',
              onMediaPicked: (media) {
                print('Multiple media picked: ${media.key}');
              },
              onMediaRemoved: (media) {
                print('Multiple media removed: ${media.key}');
              },
            ),
            
            const SizedBox(height: 32),
            
            _buildSectionTitle('3. Edit Mode (Programmatic Update)'),
            const SizedBox(height: 8),
            DSMediaPicker(
              controller: _editModeController,
              maxMedia: 1,
              title: 'Chỉnh sửa ảnh',
              onMediaPicked: (media) {
                print('Edit mode media picked: ${media.key}');
              },
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Cập nhật initial media programmatically
                      final newMedia = DSMediaPicked.fromUrl(
                        key: 'new_media_${DateTime.now().millisecondsSinceEpoch}',
                        url: 'https://picsum.photos/200/200?random=${DateTime.now().millisecondsSinceEpoch}',
                        mimetype: 'image/jpeg',
                      );
                      _editModeController.setInitialMedia(newMedia);
                    },
                    child: const Text('Cập nhật Media'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xóa initial media
                      _editModeController.setInitialMedia(null);
                    },
                    child: const Text('Xóa Media'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            _buildSectionTitle('4. Controller Info'),
            const SizedBox(height: 8),
            _buildControllerInfo('Single Controller', _singleMediaController),
            const SizedBox(height: 8),
            _buildControllerInfo('Multiple Controller', _multipleMediaController),
            const SizedBox(height: 8),
            _buildControllerInfo('Edit Controller', _editModeController),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildControllerInfo(String name, DSMediaPickerController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('Media count: ${controller.value.length}'),
          Text('Is uploading: ${controller.isUploading}'),
          Text('Is processing: ${controller.isProcessing}'),
          if (controller.value.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text('Media keys: ${controller.value.map((m) => m.key).join(', ')}'),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _singleMediaController.dispose();
    _multipleMediaController.dispose();
    _editModeController.dispose();
    super.dispose();
  }
}
