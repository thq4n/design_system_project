/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsBrandingGen {
  const $AssetsBrandingGen();

  /// File path: assets/branding/ic_logo_alone_red.png
  AssetGenImage get icLogoAloneRed =>
      const AssetGenImage('assets/branding/ic_logo_alone_red.png');

  /// File path: assets/branding/ic_logo_alone_white.png
  AssetGenImage get icLogoAloneWhite =>
      const AssetGenImage('assets/branding/ic_logo_alone_white.png');

  /// File path: assets/branding/ic_logo_full_red.png
  AssetGenImage get icLogoFullRed =>
      const AssetGenImage('assets/branding/ic_logo_full_red.png');

  /// File path: assets/branding/ic_logo_full_white.png
  AssetGenImage get icLogoFullWhite =>
      const AssetGenImage('assets/branding/ic_logo_full_white.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    icLogoAloneRed,
    icLogoAloneWhite,
    icLogoFullRed,
    icLogoFullWhite,
  ];
}

class $AssetsEmptyStateGen {
  const $AssetsEmptyStateGen();

  /// File path: assets/empty_state/icon_empty_state_error.png
  AssetGenImage get iconEmptyStateError =>
      const AssetGenImage('assets/empty_state/icon_empty_state_error.png');

  /// File path: assets/empty_state/icon_empty_state_ok.png
  AssetGenImage get iconEmptyStateOk =>
      const AssetGenImage('assets/empty_state/icon_empty_state_ok.png');

  /// File path: assets/empty_state/icon_empty_state_question.png
  AssetGenImage get iconEmptyStateQuestion =>
      const AssetGenImage('assets/empty_state/icon_empty_state_question.png');

  /// File path: assets/empty_state/icon_empty_state_search.png
  AssetGenImage get iconEmptyStateSearch =>
      const AssetGenImage('assets/empty_state/icon_empty_state_search.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    iconEmptyStateError,
    iconEmptyStateOk,
    iconEmptyStateQuestion,
    iconEmptyStateSearch,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsBrandingGen branding = $AssetsBrandingGen();
  static const $AssetsEmptyStateGen emptyState = $AssetsEmptyStateGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
