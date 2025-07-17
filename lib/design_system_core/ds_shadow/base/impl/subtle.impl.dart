part of '../../ds_shadow_core.dart';

class _DSSubtleShadow extends DSShadow {
  const _DSSubtleShadow();

  @override
  BoxShadow get boxShadow => const BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 2,
        spreadRadius: 0,
        color: Color(0x0A000000), // 4% opacity black
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSSubtleShadowCustom(offset: offset);
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSSubtleShadowCustom(blurRadius: blurRadius);
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSSubtleShadowCustom(spreadRadius: spreadRadius);
  }

  @override
  DSShadow withColor(Color color) {
    return _DSSubtleShadowCustom(color: color);
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSSubtleShadowCustom(opacity: opacity);
  }
}

class _DSSubtleShadowCustom extends DSShadow {
  final Offset? offset;
  final double? blurRadius;
  final double? spreadRadius;
  final Color? color;
  final double? opacity;

  const _DSSubtleShadowCustom({
    this.offset,
    this.blurRadius,
    this.spreadRadius,
    this.color,
    this.opacity,
  });

  @override
  BoxShadow get boxShadow => BoxShadow(
        offset: offset ?? const Offset(0, 1),
        blurRadius: blurRadius ?? 2,
        spreadRadius: spreadRadius ?? 0,
        color: (color ?? const Color(0xFF000000))
            .withValues(alpha: opacity ?? 0.04),
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSSubtleShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSSubtleShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSSubtleShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withColor(Color color) {
    return _DSSubtleShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSSubtleShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }
}
