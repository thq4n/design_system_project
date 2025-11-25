import 'dart:math';
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

import '../../design_system_project.dart';

/// Helper class for creating authentication headers
class AuthHeadersHelper {
  /// Creates headers with Bearer token
  static Map<String, String> createBearerHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  /// Creates headers with custom authorization header
  static Map<String, String> createAuthHeaders(String authorization) {
    return {
      'Authorization': authorization,
    };
  }

  /// Creates headers with multiple custom headers
  static Map<String, String> createCustomHeaders(Map<String, String> headers) {
    return Map<String, String>.from(headers);
  }
}

/// A versatile image widget that supports local assets,
///  network images, and SVG files.
///
/// This widget automatically detects the image type based on the source:
/// - Network URLs: Uses ExtendedImage with caching and loading states
/// - SVG files: Uses SvgPicture for vector graphics
/// - Local assets: Uses Image.asset for regular images
///
/// For authenticated network images, use the [headers] parameter to provide
/// authentication tokens or other required headers.
///
/// To prevent memory issues and app crashes with very large images
/// (e.g., 19000x19000 pixels), the widget automatically limits the
/// decoded image size using [maxDecodeWidth] and [maxDecodeHeight]
/// parameters (default: 4096x4096 pixels).
///
/// Example usage:
/// ```dart
/// // Basic usage
/// DSImageView(
///   source: 'https://example.com/image.jpg',
///   width: 100,
///   height: 100,
/// )
///
/// // With authentication headers
/// DSImageView(
///   source: 'https://api.example.com/protected-image.jpg',
///   headers: {
///     'Authorization': 'Bearer your_token_here',
///     'X-API-Key': 'your_api_key',
///   },
///   width: 100,
///   height: 100,
/// )
///
/// // Using extension methods for authenticated images
/// 'https://api.example.com/protected-image.jpg'
///   .withBearerToken('your_token_here')
///   .withAuthHeader('Bearer your_token_here')
///   .withHeaders({'Authorization': 'Bearer your_token_here'})
///
/// // With placeholder
/// DSImageView(
///   source: 'https://example.com/image.jpg',
///   placeHolder: 'assets/images/placeholder.png',
///   width: 100,
///   height: 100,
/// )
///
/// // Getting token from local storage (in your app)
/// final token = localDataManager.token?.accessToken;
/// if (token != null) {
///   'https://api.example.com/protected-image.jpg'
///     .withBearerToken(token)
/// }
/// ```
class DSImageView extends StatelessWidget {
  const DSImageView({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.alignment = Alignment.center,
    this.placeHolder,
    this.loadingRadius,
    this.package,
    this.headers,
    this.maxDecodeWidth,
    this.maxDecodeHeight,
  });

  /// The image source URL, asset path, or SVG path
  final String source;

  /// The width of the image
  final double? width;

  /// The height of the image
  final double? height;

  /// How the image should be fitted within its bounds
  final BoxFit? fit;

  /// Color filter to apply to the image
  final Color? color;

  /// How the image should be aligned within its bounds
  final Alignment alignment;

  /// Placeholder image to show when the main image fails to load
  final String? placeHolder;

  /// Package name for asset images
  final String? package;

  /// Radius for the loading indicator
  final double? loadingRadius;

  /// HTTP headers to include with network requests (useful for authentication)
  final Map<String, String>? headers;

  /// Maximum width for decoded image to prevent memory issues.
  /// Defaults to 4096 pixels. Images larger than this will be
  /// downscaled during decoding to prevent app crashes.
  final int? maxDecodeWidth;

  /// Maximum height for decoded image to prevent memory issues.
  /// Defaults to 4096 pixels. Images larger than this will be
  /// downscaled during decoding to prevent app crashes.
  final int? maxDecodeHeight;

  @override
  Widget build(BuildContext context) {
    return _buildImage(source.isEmpty ? placeHolder ?? '' : source);
  }

  Widget _buildImage(String image) {
    if (image.isEmpty) {
      if (placeHolder?.isNotEmpty ?? false) {
        return DSImageView(
          source: placeHolder!,
          width: width,
          height: height,
          fit: fit,
          color: color,
          alignment: alignment,
        );
      }
      return SizedBox(width: width, height: height);
    }
    if (image.isUrl) {
      return ExtendedNetworkImage(
        image,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        loadingRadius: loadingRadius,
        headers: headers,
        maxDecodeWidth: maxDecodeWidth,
        maxDecodeHeight: maxDecodeHeight,
      );
    }
    if (image.contains('.svg')) {
      return SvgPicture.asset(
        image,
        width: width,
        height: height,
        colorFilter:
            color != null ? ColorFilter.mode(color!, ui.BlendMode.srcIn) : null,
        alignment: alignment,
        package: package,
      );
    }

    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      package: package,
    );
  }
}

/// Extended network image widget with support for authentication
///  headers and custom loading/error states.
///
/// This widget wraps ExtendedImage.network
///  and provides additional functionality
/// for handling authenticated image requests and custom UI states.
///
/// To prevent memory issues with very large images (e.g., 19000x19000),
/// the widget automatically limits the decoded image size using
/// [maxDecodeWidth] and [maxDecodeHeight] parameters.
class ExtendedNetworkImage extends StatelessWidget {
  const ExtendedNetworkImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.alignment = Alignment.center,
    this.placeHolder,
    this.errorBuilder,
    this.loadingBuilder,
    this.brightness,
    this.cached = true,
    this.loadingRadius,
    this.headers,
    this.maxDecodeWidth,
    this.maxDecodeHeight,
  });

  /// The network image URL
  final String image;

  /// The width of the image
  final double? width;

  /// The height of the image
  final double? height;

  /// How the image should be fitted within its bounds
  final BoxFit? fit;

  /// Color filter to apply to the image
  final Color? color;

  /// How the image should be aligned within its bounds
  final Alignment alignment;

  /// Placeholder image to show when the main image fails to load
  final String? placeHolder;

  /// Custom error widget builder
  final Widget Function(ExtendedImageState state)? errorBuilder;

  /// Custom loading widget builder
  final Widget Function(ExtendedImageState state)? loadingBuilder;

  /// Brightness for the loading indicator
  final Brightness? brightness;

  /// Whether to cache the image
  final bool cached;

  /// Radius for the loading indicator
  final double? loadingRadius;

  /// HTTP headers to include with network requests (useful for authentication)
  final Map<String, String>? headers;

  /// Maximum width for decoded image to prevent memory issues.
  /// Defaults to 4096 pixels. Images larger than this will be
  /// downscaled during decoding to prevent app crashes.
  final int? maxDecodeWidth;

  /// Maximum height for decoded image to prevent memory issues.
  /// Defaults to 4096 pixels. Images larger than this will be
  /// downscaled during decoding to prevent app crashes.
  final int? maxDecodeHeight;

  @override
  Widget build(BuildContext context) {
    // Calculate maximum decode dimensions to prevent memory issues
    // Default to 4096x4096 to prevent crashes with very large images
    final int effectiveMaxWidth = maxDecodeWidth ?? 4096;
    final int effectiveMaxHeight = maxDecodeHeight ?? 4096;

    // Use ExtendedNetworkImageProvider and wrap it with ResizeImage
    // to limit decoded image size and prevent memory issues/crashes
    // with very large images (e.g., 19000x19000)
    final baseProvider = ExtendedNetworkImageProvider(
      image,
      headers: headers,
    );

    // Wrap with ResizeImage to limit decode size
    final imageProvider = ResizeImage(
      baseProvider,
      width: effectiveMaxWidth,
      height: effectiveMaxHeight,
      allowUpscaling: false,
    );

    return ExtendedImage(
      image: imageProvider,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return loadingBuilder?.call(state) ??
                DSLoading(
                  brightness:
                      brightness ?? MediaQuery.of(context).platformBrightness,
                  radius: maxLoadingSize,
                );
          case LoadState.failed:
            if (errorBuilder != null) {
              return errorBuilder!.call(state);
            }
            if (placeHolder?.isNotEmpty ?? false) {
              return DSImageView(
                source: placeHolder!,
                width: width,
                height: height,
                fit: fit,
                alignment: alignment,
                color: color,
              );
            }

            return Padding(
              padding: const EdgeInsets.all(24),
              child: DSImageView(
                source: DSAssets.vuesax.infoCircleBold,
                width: DSIconSizes.size24,
                height: DSIconSizes.size24,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            );
          case LoadState.completed:
            if (state.wasSynchronouslyLoaded) {
              return state.completedWidget;
            }
            return null;
        }
      },
    );
  }

  double get maxLoadingSize {
    if (loadingRadius != null) {
      return loadingRadius!;
    }
    if (width != null && height != null) {
      return min(12, min(width!, height!) * 3 / 2);
    }
    return 12;
  }
}

/// Factory class for creating ImageProvider instances
///  with support for authentication headers and size limits.
///
/// This factory automatically detects the image
///  type and creates the appropriate
/// ImageProvider with optional headers for network requests.
///
/// To prevent memory issues with very large images, the factory
/// automatically wraps network image providers with ResizeImage
/// to limit the decoded image size.
///
/// Example usage:
/// ```dart
/// // For authenticated images
/// final provider = ImageViewProviderFactory(
///   'https://api.example.com/protected-image.jpg',
///   headers: {
///     'Authorization': 'Bearer your_token_here',
///   },
/// ).provider;
///
/// // For regular images
/// final provider = ImageViewProviderFactory(
///   'https://example.com/image.jpg',
/// ).provider;
///
/// // With custom size limits
/// final provider = ImageViewProviderFactory(
///   'https://example.com/large-image.jpg',
///   maxDecodeWidth: 2048,
///   maxDecodeHeight: 2048,
/// ).provider;
/// ```
class ImageViewProviderFactory {
  ImageViewProviderFactory(
    this.source, {
    this.headers,
    this.maxDecodeWidth,
    this.maxDecodeHeight,
  }) : provider = source.let((it) {
          if (it?.isUrl ?? false) {
            final baseProvider = ExtendedNetworkImageProvider(
              it!,
              headers: headers,
            );

            // Calculate maximum decode dimensions to prevent memory issues
            // Default to 4096x4096 to prevent crashes with very large images
            final int effectiveMaxWidth = maxDecodeWidth ?? 4096;
            final int effectiveMaxHeight = maxDecodeHeight ?? 4096;

            // Wrap with ResizeImage to limit decode size
            return ResizeImage(
              baseProvider,
              width: effectiveMaxWidth,
              height: effectiveMaxHeight,
              allowUpscaling: false,
            );
          }
          if (it?.contains('.svg') ?? false) {
            return svg_provider.Svg(it!);
          }
          return AssetImage(it!);
        });

  /// The image source URL, asset path, or SVG path
  final String source;

  /// HTTP headers to include with network requests (useful for authentication)
  final Map<String, String>? headers;

  /// Maximum width for decoded image to prevent memory issues.
  /// Defaults to 4096 pixels. Images larger than this will be
  /// downscaled during decoding to prevent app crashes.
  final int? maxDecodeWidth;

  /// Maximum height for decoded image to prevent memory issues.
  /// Defaults to 4096 pixels. Images larger than this will be
  /// downscaled during decoding to prevent app crashes.
  final int? maxDecodeHeight;

  /// The created ImageProvider instance
  final ImageProvider provider;
}
