// ignore_for_file: unused_field

part of '../ds_icon_core.dart';

enum _DSIconTypeConstants {
  system(
    'system',
    [
      _DSIconSizeConstants.size16,
      _DSIconSizeConstants.size20,
      _DSIconSizeConstants.size24,
      _DSIconSizeConstants.size48
    ],
  ),
  service(
    'service',
    [
      _DSIconSizeConstants.size24,
      _DSIconSizeConstants.size48,
    ],
  ),
  social(
    'social',
    [
      _DSIconSizeConstants.size24,
    ],
  );

  final String name;
  final List<_DSIconSizeConstants> sizes;

  const _DSIconTypeConstants(this.name, this.sizes);
}
