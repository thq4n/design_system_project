part of '../../ds_radius_core.dart';

class _DSRadiusRoundedLg extends DSRadius {
  const _DSRadiusRoundedLg() : super.circular(16);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(16);
}
