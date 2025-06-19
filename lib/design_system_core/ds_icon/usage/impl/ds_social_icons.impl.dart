part of '../../ds_icon_core.dart';

class DSSocialIcons extends _DSIcons {
  static final _library = _DSIconSocial(library: const $AssetsSocialGen());
  static final _sizes = DSSystemIconSizes();

  static SvgPicture icon(
    SvgGenImage Function(
      $AssetsSocialGen icons,
    ) create, {
    double? Function(
      DSSystemIconSizes sizes,
    )? getSize,
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    Color? color,
  }) {
    return create(_library.library).svg(
      width: getSize?.call(_sizes),
      height: getSize?.call(_sizes),
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter ??
          (color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null),
      clipBehavior: clipBehavior,
    );
  }
}
