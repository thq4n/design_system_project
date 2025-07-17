part of '../ds_shadow_core.dart';

abstract class DSShadow {
  const DSShadow();

  BoxShadow get boxShadow;
  List<BoxShadow> get boxShadows;

  /// Creates a shadow with custom offset
  DSShadow withOffset(Offset offset);

  /// Creates a shadow with custom blur radius
  DSShadow withBlurRadius(double blurRadius);

  /// Creates a shadow with custom spread radius
  DSShadow withSpreadRadius(double spreadRadius);

  /// Creates a shadow with custom color
  DSShadow withColor(Color color);

  /// Creates a shadow with custom opacity
  DSShadow withOpacity(double opacity);

  /// Applies the shadow to a widget
  Widget apply(Widget child) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadows,
      ),
      child: child,
    );
  }
}
