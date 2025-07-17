// ignore_for_file: unused_element

part of '../../ds_color_usage_core.dart';

class _DSBorderColorUsage extends DSColorUsage {
  const _DSBorderColorUsage();

  DSColors get colors => const DSColors();

  DSColor get primary => colors.gray.tint300;
  DSColor get secondary => colors.gray.tint200;
  DSColor get tertiary => colors.gray.tint100;
  DSColor get brand => colors.brand.shade500;
  DSColor get error => colors.orange.shade600;
  DSColor get success => colors.green.shade500;
}
