part of '../../ds_shadow_core.dart';

class DSShadows extends _DSShadows {
  DSShadows._();

  /// Subtle shadow - very light shadow for subtle elevation
  static List<BoxShadow> get subtle => const _DSSubtleShadow().boxShadows;

  /// Light shadow - light shadow for slight elevation
  static List<BoxShadow> get light => const _DSLightShadow().boxShadows;

  /// Medium shadow - medium shadow for moderate elevation
  static List<BoxShadow> get medium => const _DSMediumShadow().boxShadows;

  /// Strong shadow - strong shadow for significant elevation
  static List<BoxShadow> get strong => const _DSStrongShadow().boxShadows;

  /// Intense shadow - intense shadow for maximum elevation
  static List<BoxShadow> get intense => const _DSIntenseShadow().boxShadows;

  /// Creates a custom shadow with specified parameters
  static List<BoxShadow> custom({
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
    ).boxShadows;
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
