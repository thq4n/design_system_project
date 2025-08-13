part of '../../ds_radius_core.dart';

class _DSRadiusRoundedXs extends DSRadius {
  const _DSRadiusRoundedXs() : super.circular(4);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(4);
}
