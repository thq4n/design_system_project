part of '../constants.dart';
// ignore_for_file: unused_field

enum _DSIconSizeConstants {
  size16(16),
  size20(20),
  size24(24),
  size40(40),
  size48(48);

  final double value;

  const _DSIconSizeConstants(this.value);
}

class DSIconSizes {
  DSIconSizes._();

  static final size16 = _DSIconSizeConstants.size16.value;
  static final size20 = _DSIconSizeConstants.size20.value;
  static final size24 = _DSIconSizeConstants.size24.value;
  static final size40 = _DSIconSizeConstants.size40.value;
  static final size48 = _DSIconSizeConstants.size48.value;
}
