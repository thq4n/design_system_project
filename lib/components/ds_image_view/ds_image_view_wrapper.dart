import 'package:flutter/widgets.dart';

import '../../gen/assets.gen.dart';
import 'ds_image_view.dart';

class DSImageViewWrapper extends DSImageView {
  DSImageViewWrapper.avatar(
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

  DSImageViewWrapper.item(
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

  DSImageViewWrapper.banner(
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
