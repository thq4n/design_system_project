part of '../../ds_radius_core.dart';

class _DSRadiusRoundedXL extends DSRadius {
  const _DSRadiusRoundedXL() : super.circular(20);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(20);
}
