import 'dart:math';
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

import '../../design_system_project.dart';

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
  });

  final String source;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Alignment alignment;
  final String? placeHolder;
  final String? package;
  final double? loadingRadius;

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
  });

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Alignment alignment;
  final String? placeHolder;
  final Widget Function(ExtendedImageState state)? errorBuilder;
  final Widget Function(ExtendedImageState state)? loadingBuilder;
  final Brightness? brightness;
  final bool cached;
  final double? loadingRadius;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      image,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      cache: cached,
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

class ImageViewProviderFactory {
  ImageViewProviderFactory(this.source)
      : provider = source.let((it) {
          if (it?.isUrl ?? false) {
            return ExtendedNetworkImageProvider(it!);
          }
          if (it?.contains('.svg') ?? false) {
            return svg_provider.Svg(it!);
          }
          return AssetImage(it!);
        });

  final String source;
  final ImageProvider provider;
}
