part of '../ds_radius_core.dart';

abstract class DSRadius extends Radius {
  const DSRadius.circular(super.radius) : super.circular();

  BorderRadiusGeometry? get borderRadiusGeometry;
}
