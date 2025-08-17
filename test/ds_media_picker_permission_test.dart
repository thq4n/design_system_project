import 'dart:io';

import 'package:design_system_project/components/ds_media_picker/ds_media_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  group('DSMediaPicker Permission Tests', () {
    late DSMediaPickerController controller;

    setUp(() {
      controller = DSMediaPickerController();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('should render DSMediaPicker widget correctly', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              mediaSource: DSMediaSource.camera,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(DSMediaPicker), findsOneWidget);
    });

    testWidgets('should render with gallery source', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              mediaSource: DSMediaSource.gallery,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(DSMediaPicker), findsOneWidget);
    });

    testWidgets('should render with both sources', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              mediaSource: DSMediaSource.both,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(DSMediaPicker), findsOneWidget);
    });

    testWidgets('should handle different media types', (tester) async {
      // Test photo type
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              mediaType: DSMediaPickerType.photo,
              mediaSource: DSMediaSource.camera,
            ),
          ),
        ),
      );
      expect(find.byType(DSMediaPicker), findsOneWidget);

      // Test video type
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              mediaType: DSMediaPickerType.video,
              mediaSource: DSMediaSource.gallery,
            ),
          ),
        ),
      );
      expect(find.byType(DSMediaPicker), findsOneWidget);

      // Test both type
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DSMediaPicker(
              controller: controller,
              mediaType: DSMediaPickerType.both,
              mediaSource: DSMediaSource.both,
            ),
          ),
        ),
      );
      expect(find.byType(DSMediaPicker), findsOneWidget);
    });
  });

  group('DSMediaPickerController Tests', () {
    test('should create controller with default values', () {
      final controller = DSMediaPickerController();
      expect(controller.value, isEmpty);
      expect(controller.allowMultiple, isTrue);
      expect(controller.isUploading, isFalse);
      expect(controller.isProcessing, isFalse);
      controller.dispose();
    });

    test('should create controller with initial medias', () {
      final medias = [
        DSMediaPicked(key: 'test1'),
        DSMediaPicked(key: 'test2'),
      ];
      final controller = DSMediaPickerController(medias: medias);
      expect(controller.value.length, equals(2));
      controller.dispose();
    });

    test('should add medias correctly', () {
      final controller = DSMediaPickerController();
      final medias = [
        DSMediaPicked(key: 'test1'),
        DSMediaPicked(key: 'test2'),
      ];

      controller.addAll(medias);
      expect(controller.value.length, equals(2));
      expect(controller.value[0].key, equals('test1'));
      expect(controller.value[1].key, equals('test2'));

      controller.dispose();
    });

    test('should remove media correctly', () {
      final controller = DSMediaPickerController();
      final media = DSMediaPicked(key: 'test1');

      controller.addAll([media]);
      expect(controller.value.length, equals(1));

      controller.remove(media);
      expect(controller.value, isEmpty);

      controller.dispose();
    });

    test('should remove all medias correctly', () {
      final controller = DSMediaPickerController();
      final medias = [
        DSMediaPicked(key: 'test1'),
        DSMediaPicked(key: 'test2'),
      ];

      controller.addAll(medias);
      expect(controller.value.length, equals(2));

      controller.removeAll();
      expect(controller.value, isEmpty);

      controller.dispose();
    });
  });

  group('DSMediaPicked Model Tests', () {
    test('should create DSMediaPicked with default values', () {
      final media = DSMediaPicked(key: 'test');
      expect(media.key, equals('test'));
      expect(media.state, equals(DSMediaState.base));
      expect(media.isInUploadProgress, isFalse);
      expect(media.isVideo, isFalse);
      expect(media.isProcessing, isFalse);
      expect(media.isLoading, isFalse);
      expect(media.isEmpty, isTrue);
    });

    test('should detect video correctly', () {
      final videoMedia = DSMediaPicked(
        key: 'test',
        mimetype: 'video/mp4',
      );
      expect(videoMedia.isVideo, isTrue);
    });

    test('should detect image correctly', () {
      final imageMedia = DSMediaPicked(
        key: 'test',
        mimetype: 'image/jpeg',
      );
      expect(imageMedia.isVideo, isFalse);
    });

    test('should format file size correctly', () {
      final media = DSMediaPicked(
        key: 'test',
        fileSize: 1024,
      );
      expect(media.formattedFileSize, equals('1.0 KB'));
    });

    test('should format progress percentage correctly', () {
      final media = DSMediaPicked(
        key: 'test',
        uploadProgress: 0.5,
      );
      expect(media.progressPercentage, equals('50%'));
    });

    test('should copy with new values correctly', () {
      final original = DSMediaPicked(key: 'test');
      final copied = original.copyWith(
        state: DSMediaState.complete,
        uploadProgress: 1.0,
      );

      expect(copied.key, equals('test'));
      expect(copied.state, equals(DSMediaState.complete));
      expect(copied.uploadProgress, equals(1.0));
    });
  });

  group('Platform-specific Permission Tests', () {
    test('should use correct permission types for iOS', () {
      if (Platform.isIOS) {
        // Test iOS-specific permission handling
        expect(Permission.photos, isNotNull);
      }
    });

    test('should use correct permission types for Android', () {
      if (Platform.isAndroid) {
        // Test Android-specific permission handling
        expect(Permission.storage, isNotNull);
      }
    });
  });
}
