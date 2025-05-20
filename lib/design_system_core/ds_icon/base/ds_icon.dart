part of '../ds_icon_core.dart';

abstract class DSIcon extends IconData {
  const DSIcon(
    super.codePoint, {
    super.fontFamily,
    super.matchTextDirection,
    super.fontFamilyFallback,
  });
}
