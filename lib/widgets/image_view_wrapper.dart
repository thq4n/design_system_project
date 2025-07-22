import 'package:flutter/widgets.dart';

import '../components/ds_image_view/ds_image_view.dart';
import '../gen/assets.gen.dart';

class ImageViewWrapper extends DSImageView {
  ImageViewWrapper.avatar(
    String source, {
    super.width,
    super.height,
    super.fit,
    super.color,
    super.alignment = Alignment.center,
    super.package,
    super.loadingRadius,
  }) : super(
          source: source,
          placeHolder: DSAssets.branding.icLogoAloneRed,
        );

  ImageViewWrapper.item(
    String source, {
    super.width,
    super.height,
    super.fit,
    super.color,
    super.alignment = Alignment.center,
    super.package,
    super.loadingRadius,
  }) : super(
          source: source,
          placeHolder: DSAssets.branding.icLogoFullRed,
        );

  ImageViewWrapper.banner(
    String source, {
    super.width,
    super.height,
    super.fit,
    super.color,
    super.alignment = Alignment.center,
    super.package,
    super.loadingRadius,
  }) : super(
          source: source,
          placeHolder: DSAssets.branding.icLogoFullRed,
        );
}
