part of '../../ds_shadow_core.dart';

class _DSStrongShadow extends DSShadow {
  const _DSStrongShadow();

  @override
  BoxShadow get boxShadow => const BoxShadow(
        offset: Offset(0, 8),
        blurRadius: 16,
        spreadRadius: 0,
        color: Color(0x29000000), // 16% opacity black
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSStrongShadowCustom(offset: offset);
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSStrongShadowCustom(blurRadius: blurRadius);
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSStrongShadowCustom(spreadRadius: spreadRadius);
  }

  @override
  DSShadow withColor(Color color) {
    return _DSStrongShadowCustom(color: color);
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSStrongShadowCustom(opacity: opacity);
  }
}

class _DSStrongShadowCustom extends DSShadow {
  final Offset? offset;
  final double? blurRadius;
  final double? spreadRadius;
  final Color? color;
  final double? opacity;

  const _DSStrongShadowCustom({
    this.offset,
    this.blurRadius,
    this.spreadRadius,
    this.color,
    this.opacity,
  });

  @override
  BoxShadow get boxShadow => BoxShadow(
        offset: offset ?? const Offset(0, 8),
        blurRadius: blurRadius ?? 16,
        spreadRadius: spreadRadius ?? 0,
        color: (color ?? const Color(0xFF000000))
            .withValues(alpha: opacity ?? 0.16),
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSStrongShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSStrongShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSStrongShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withColor(Color color) {
    return _DSStrongShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSStrongShadowCustom(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }
}
