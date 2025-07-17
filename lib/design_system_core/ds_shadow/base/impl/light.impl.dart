part of '../../ds_shadow_core.dart';

class _DSLightShadow extends DSShadow {
  const _DSLightShadow();

  @override
  BoxShadow get boxShadow => const BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 4,
        spreadRadius: 0,
        color: Color(0x14000000), // 8% opacity black
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSLightShadowCustom(offset: offset);
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSLightShadowCustom(blurRadius: blurRadius);
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSLightShadowCustom(spreadRadius: spreadRadius);
  }

  @override
  DSShadow withColor(Color color) {
    return _DSLightShadowCustom(color: color);
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSLightShadowCustom(opacity: opacity);
  }
}

class _DSLightShadowCustom extends DSShadow {
  final Offset? offset;
  final double? blurRadius;
  final double? spreadRadius;
  final Color? color;
  final double? opacity;

  const _DSLightShadowCustom({
    this.offset,
    this.blurRadius,
    this.spreadRadius,
    this.color,
    this.opacity,
  });

  @override
  BoxShadow get boxShadow => BoxShadow(
        offset: offset ?? const Offset(0, 2),
        blurRadius: blurRadius ?? 4,
        spreadRadius: spreadRadius ?? 0,
        color: (color ?? const Color(0xFF000000))
            .withValues(alpha: opacity ?? 0.08),
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSLightShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSLightShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSLightShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withColor(Color color) {
    return _DSLightShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSLightShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }
}
