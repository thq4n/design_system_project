part of '../../ds_radius_core.dart';

class _DSRadiusRoundedFull extends DSRadius {
  const _DSRadiusRoundedFull() : super.circular(9999);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(9999);
}
