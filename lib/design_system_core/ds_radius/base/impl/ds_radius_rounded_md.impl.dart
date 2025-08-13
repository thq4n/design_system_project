part of '../../ds_radius_core.dart';

class _DSRadiusRoundedMd extends DSRadius {
  const _DSRadiusRoundedMd() : super.circular(12);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(12);
}
