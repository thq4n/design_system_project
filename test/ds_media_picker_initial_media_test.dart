import 'dart:io';

import 'package:design_system_project/components/ds_media_picker/ds_media_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DSMediaPicker Initial Media Tests', () {
    late DSMediaPickerController controller;

    setUp(() {
      controller = DSMediaPickerController();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('should initialize with initialMedia when maxMedia = 1',
        (tester) async {
      // Arrange
      final initialMedia = DSMediaPicked.fromUrl(
        key: 'test_media_1',
        url: 'https://example.com/image.jpg',
        mimetype: 'image/jpeg',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              maxMedia: 1,
              initialMedia: initialMedia,
            ),
          ),
        ),
      );

      // Assert
      expect(controller.value.length, 1);
      expect(controller.value.first.key, 'test_media_1');
      expect(controller.value.first.url, 'https://example.com/image.jpg');
    });

    testWidgets('should initialize with initialMedia when maxMedia > 1',
        (tester) async {
      // Arrange
      final initialMedia = DSMediaPicked.fromUrl(
        key: 'test_media_1',
        url: 'https://example.com/image.jpg',
        mimetype: 'image/jpeg',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              maxMedia: 5,
              initialMedia: initialMedia,
            ),
          ),
        ),
      );

      // Assert
      expect(controller.value.length, 1);
      expect(controller.value.first.key, 'test_media_1');
      expect(controller.value.first.url, 'https://example.com/image.jpg');
    });

    testWidgets('should not add duplicate initialMedia', (tester) async {
      // Arrange
      final initialMedia = DSMediaPicked.fromUrl(
        key: 'test_media_1',
        url: 'https://example.com/image.jpg',
        mimetype: 'image/jpeg',
      );

      // Thêm media vào controller trước
      controller.addAll([initialMedia]);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              maxMedia: 5,
              initialMedia: initialMedia,
            ),
          ),
        ),
      );

      // Assert
      expect(controller.value.length, 1); // Không thêm duplicate
      expect(controller.value.first.key, 'test_media_1');
    });

    testWidgets('should clear media when initialMedia is null', (tester) async {
      // Arrange
      final initialMedia = DSMediaPicked.fromUrl(
        key: 'test_media_1',
        url: 'https://example.com/image.jpg',
        mimetype: 'image/jpeg',
      );

      // Thêm media vào controller trước
      controller.addAll([initialMedia]);

      // Act - Set initialMedia to null
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              maxMedia: 5,
              initialMedia: null,
            ),
          ),
        ),
      );

      // Assert
      expect(controller.value.length, 0); // Media đã bị xóa
    });

    testWidgets('should update initialMedia when widget is rebuilt',
        (tester) async {
      // Arrange
      final initialMedia1 = DSMediaPicked.fromUrl(
        key: 'test_media_1',
        url: 'https://example.com/image1.jpg',
        mimetype: 'image/jpeg',
      );

      final initialMedia2 = DSMediaPicked.fromUrl(
        key: 'test_media_2',
        url: 'https://example.com/image2.jpg',
        mimetype: 'image/jpeg',
      );

      // Act - Build với initialMedia1
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              maxMedia: 1,
              initialMedia: initialMedia1,
            ),
          ),
        ),
      );

      // Assert
      expect(controller.value.length, 1);
      expect(controller.value.first.key, 'test_media_1');

      // Act - Rebuild với initialMedia2
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              maxMedia: 1,
              initialMedia: initialMedia2,
            ),
          ),
        ),
      );

      // Assert
      expect(controller.value.length, 1);
      expect(controller.value.first.key, 'test_media_2');
    });

    testWidgets('should call onMediaPicked callback when initialMedia is added',
        (tester) async {
      // Arrange
      final initialMedia = DSMediaPicked.fromUrl(
        key: 'test_media_1',
        url: 'https://example.com/image.jpg',
        mimetype: 'image/jpeg',
      );

      DSMediaPicked? pickedMedia;
      final onMediaPicked = (DSMediaPicked media) {
        pickedMedia = media;
      };

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              maxMedia: 1,
              initialMedia: initialMedia,
              onMediaPicked: onMediaPicked,
            ),
          ),
        ),
      );

      // Assert
      expect(pickedMedia, isNotNull);
      expect(pickedMedia!.key, 'test_media_1');
    });

    test('DSMediaPicked.fromUrl should create correct instance', () {
      // Arrange & Act
      final media = DSMediaPicked.fromUrl(
        key: 'test_key',
        url: 'https://example.com/image.jpg',
        mimetype: 'image/jpeg',
        fileSize: 1024,
      );

      // Assert
      expect(media.key, 'test_key');
      expect(media.url, 'https://example.com/image.jpg');
      expect(media.mimetype, 'image/jpeg');
      expect(media.fileSize, 1024);
      expect(media.state, DSMediaState.complete);
      expect(media.mediaFile, isNull);
    });

    test('DSMediaPicked.fromFile should create correct instance', () {
      // Arrange
      final file = File('/path/to/image.jpg');

      // Act
      final media = DSMediaPicked.fromFile(
        key: 'test_key',
        file: file,
        mimetype: 'image/jpeg',
        fileSize: 1024,
      );

      // Assert
      expect(media.key, 'test_key');
      expect(media.mediaFile, file);
      expect(media.mimetype, 'image/jpeg');
      expect(media.fileSize, 1024);
      expect(media.state, DSMediaState.complete);
      expect(media.url, isNull);
    });

    test('controller.setInitialMedia should work correctly', () {
      // Arrange
      final initialMedia = DSMediaPicked.fromUrl(
        key: 'test_media_1',
        url: 'https://example.com/image.jpg',
        mimetype: 'image/jpeg',
      );

      // Act
      controller.setInitialMedia(initialMedia);

      // Assert
      expect(controller.value.length, 1);
      expect(controller.value.first.key, 'test_media_1');

      // Act - Set to null
      controller.setInitialMedia(null);

      // Assert
      expect(controller.value.length, 0);
    });
  });
}
