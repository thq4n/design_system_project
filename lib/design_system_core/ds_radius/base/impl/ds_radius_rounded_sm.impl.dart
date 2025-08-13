part of '../../ds_radius_core.dart';

class _DSRadiusRoundedSm extends DSRadius {
  const _DSRadiusRoundedSm() : super.circular(8);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(8);
}
