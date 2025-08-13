part of '../../ds_radius_core.dart';

class DSRadiuses extends _DSRadiuses {
  DSRadiuses._();

  static DSRadius get radiusNone => const _DSRadiusRoundedNone();
  static DSRadius get radiusXxs => const _DSRadiusRoundedXxs();
  static DSRadius get radiusXs => const _DSRadiusRoundedXs();
  static DSRadius get radiusSm => const _DSRadiusRoundedSm();
  static DSRadius get radiusMd => const _DSRadiusRoundedMd();
  static DSRadius get radiusLg => const _DSRadiusRoundedLg();
  static DSRadius get radiusXl => const _DSRadiusRoundedXL();
  static DSRadius get radius2xl => const _DSRadiusRounded2XL();
  static DSRadius get radius3xl => const _DSRadiusRounded3XL();
  static DSRadius get radius4xl => const _DSRadiusRounded4XL();
  static DSRadius get radiusFull => const _DSRadiusRoundedFull();
}
