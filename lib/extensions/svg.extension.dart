part of 'extensions.dart';

extension SvgGenExtension on SvgGenImage {
  _svg.SvgPicture dsSvg({
    Key? key,
    bool matchTextDirection = false,
    String? package,
    AssetBundle? bundle,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    Color? color,
  }) =>
      svg(
        key: key,
        matchTextDirection: matchTextDirection,
        bundle: bundle,
        width: width,
        height: height,
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
