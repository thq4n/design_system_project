part of '../../ds_shadow_core.dart';

class DSShadows extends _DSShadows {
  /// Subtle shadow - very light shadow for subtle elevation
  static DSShadow get subtle => const _DSSubtleShadow();

  /// Light shadow - light shadow for slight elevation
  static DSShadow get light => const _DSLightShadow();

  /// Medium shadow - medium shadow for moderate elevation
  static DSShadow get medium => const _DSMediumShadow();

  /// Strong shadow - strong shadow for significant elevation
  static DSShadow get strong => const _DSStrongShadow();

  /// Intense shadow - intense shadow for maximum elevation
  static DSShadow get intense => const _DSIntenseShadow();

  /// Creates a custom shadow with specified parameters
  static DSShadow custom({
    Offset offset = const Offset(0, 4),
    double blurRadius = 8,
    double spreadRadius = 0,
    Color color = const Color(0xFF000000),
    double opacity = 0.12,
  }) {
    return _DSCustomShadow(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }
}

class _DSCustomShadow extends DSShadow {
  final Offset offset;
  final double blurRadius;
  final double spreadRadius;
  final Color color;
  final double opacity;

  const _DSCustomShadow({
    required this.offset,
    required this.blurRadius,
    required this.spreadRadius,
    required this.color,
    required this.opacity,
  });

  @override
  BoxShadow get boxShadow => BoxShadow(
        offset: offset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        color: color.withValues(alpha: opacity),
      );

  @override
  List<BoxShadow> get boxShadows => [boxShadow];

  @override
  DSShadow withOffset(Offset offset) {
    return _DSCustomShadow(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withBlurRadius(double blurRadius) {
    return _DSCustomShadow(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withSpreadRadius(double spreadRadius) {
    return _DSCustomShadow(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withColor(Color color) {
    return _DSCustomShadow(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }

  @override
  DSShadow withOpacity(double opacity) {
    return _DSCustomShadow(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: color,
      opacity: opacity,
    );
  }
}
