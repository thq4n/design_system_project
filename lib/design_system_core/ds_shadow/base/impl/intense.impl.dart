part of '../../ds_shadow_core.dart';

class _DSIntenseShadow extends DSShadow {
  const _DSIntenseShadow();

  @override
  BoxShadow get boxShadow => const BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 32,
        spreadRadius: 0,
        color: Color(0x33000000), // 20% opacity black
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSIntenseShadowCustom(offset: offset);
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSIntenseShadowCustom(blurRadius: blurRadius);
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSIntenseShadowCustom(spreadRadius: spreadRadius);
  }

  @override
  DSShadow withColor(Color color) {
    return _DSIntenseShadowCustom(color: color);
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSIntenseShadowCustom(opacity: opacity);
  }
}

class _DSIntenseShadowCustom extends DSShadow {
  final Offset? offset;
  final double? blurRadius;
  final double? spreadRadius;
  final Color? color;
  final double? opacity;

  const _DSIntenseShadowCustom({
    this.offset,
    this.blurRadius,
    this.spreadRadius,
    this.color,
    this.opacity,
  });

  @override
  BoxShadow get boxShadow => BoxShadow(
        offset: offset ?? const Offset(0, 16),
        blurRadius: blurRadius ?? 32,
        spreadRadius: spreadRadius ?? 0,
        color: (color ?? const Color(0xFF000000))
            .withValues(alpha: opacity ?? 0.20),
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSIntenseShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSIntenseShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSIntenseShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withColor(Color color) {
    return _DSIntenseShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSIntenseShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }
}
