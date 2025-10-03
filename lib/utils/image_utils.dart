import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

/// Utility class for image processing operations
class ImageUtils {
  /// Resize image to maximum FullHD resolution (1920x1080)
  ///  while maintaining aspect ratio
  ///
  /// [imageFile] - The input image file
  /// [maxWidth] - Maximum width (default: 1920)
  /// [maxHeight] - Maximum height (default: 1080)
  /// [quality] - JPEG quality (0-100, default: 85)
  ///
  /// Returns the resized image file or null if error occurs
  static Future<File?> resizeImageToFullHD({
    required File imageFile,
    int maxWidth = 1920,
    int maxHeight = 1080,
    int quality = 85,
  }) async {
    try {
      // Read the image file
      final Uint8List imageBytes = await imageFile.readAsBytes();

      // Decode the image
      final img.Image? originalImage = img.decodeImage(imageBytes);
      if (originalImage == null) {
        return null;
      }

      // Calculate new dimensions while maintaining aspect ratio
      final int originalWidth = originalImage.width;
      final int originalHeight = originalImage.height;

      // If image is already smaller than max dimensions, return original
      if (originalWidth <= maxWidth && originalHeight <= maxHeight) {
        return imageFile;
      }

      // Calculate scaling factor
      final double widthRatio = maxWidth / originalWidth;
      final double heightRatio = maxHeight / originalHeight;
      final double scaleFactor =
          widthRatio < heightRatio ? widthRatio : heightRatio;

      // Calculate new dimensions
      final int newWidth = (originalWidth * scaleFactor).round();
      final int newHeight = (originalHeight * scaleFactor).round();

      // Resize the image
      final img.Image resizedImage = img.copyResize(
        originalImage,
        width: newWidth,
        height: newHeight,
        interpolation: img.Interpolation.cubic,
      );

      // Get temporary directory
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          'resized_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File resizedFile = File('${tempDir.path}/$fileName');

      // Encode and save the resized image
      final Uint8List resizedBytes =
          img.encodeJpg(resizedImage, quality: quality);
      await resizedFile.writeAsBytes(resizedBytes);

      return resizedFile;
    } catch (e) {
      // Return original file if resize fails
      return imageFile;
    }
  }

  /// Get image dimensions without loading the full image
  ///
  /// [imageFile] - The input image file
  ///
  /// Returns a Map with 'width' and 'height' keys, or null if error occurs
  static Future<Map<String, int>?> getImageDimensions(File imageFile) async {
    try {
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);

      if (image != null) {
        return {
          'width': image.width,
          'height': image.height,
        };
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if image needs resizing based on dimensions
  ///
  /// [imageFile] - The input image file
  /// [maxWidth] - Maximum width (default: 1920)
  /// [maxHeight] - Maximum height (default: 1080)
  ///
  /// Returns true if image needs resizing, false otherwise
  static Future<bool> needsResizing({
    required File imageFile,
    int maxWidth = 1920,
    int maxHeight = 1080,
  }) async {
    final dimensions = await getImageDimensions(imageFile);
    if (dimensions == null) {
      return false;
    }

    return dimensions['width']! > maxWidth || dimensions['height']! > maxHeight;
  }

  /// Get file size in bytes
  ///
  /// [file] - The file to check
  ///
  /// Returns file size in bytes
  static Future<int> getFileSize(File file) async {
    try {
      return await file.length();
    } catch (e) {
      return 0;
    }
  }

  /// Format file size to human readable format
  ///
  /// [bytes] - File size in bytes
  ///
  /// Returns formatted string (e.g., "1.5 MB")
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
