part of '../../ds_radius_core.dart';

class _DSRadiusRoundedXxs extends DSRadius {
  const _DSRadiusRoundedXxs() : super.circular(2);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(2);
}
