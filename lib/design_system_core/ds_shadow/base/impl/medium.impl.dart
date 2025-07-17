part of '../../ds_shadow_core.dart';

class _DSMediumShadow extends DSShadow {
  const _DSMediumShadow();

  @override
  BoxShadow get boxShadow => const BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 8,
        spreadRadius: 0,
        color: Color(0x1F000000), // 12% opacity black
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSMediumShadowCustom(offset: offset);
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSMediumShadowCustom(blurRadius: blurRadius);
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSMediumShadowCustom(spreadRadius: spreadRadius);
  }

  @override
  DSShadow withColor(Color color) {
    return _DSMediumShadowCustom(color: color);
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSMediumShadowCustom(opacity: opacity);
  }
}

class _DSMediumShadowCustom extends DSShadow {
  final Offset? offset;
  final double? blurRadius;
  final double? spreadRadius;
  final Color? color;
  final double? opacity;

  const _DSMediumShadowCustom({
    this.offset,
    this.blurRadius,
    this.spreadRadius,
    this.color,
    this.opacity,
  });

  @override
  BoxShadow get boxShadow => BoxShadow(
        offset: offset ?? const Offset(0, 4),
        blurRadius: blurRadius ?? 8,
        spreadRadius: spreadRadius ?? 0,
        color: (color ?? const Color(0xFF000000))
            .withValues(alpha: opacity ?? 0.12),
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSMediumShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSMediumShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSMediumShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withColor(Color color) {
    return _DSMediumShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSMediumShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }
}
