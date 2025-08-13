part of '../../ds_radius_core.dart';

class _DSRadiusRoundedNone extends DSRadius {
  const _DSRadiusRoundedNone() : super.circular(0);

  @override
  BorderRadiusGeometry? get borderRadiusGeometry => BorderRadius.circular(0);
}
