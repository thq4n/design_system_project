// ignore_for_file: unused_element

part of '../../ds_color_usage_core.dart';

class _DSBorderColorUsage extends DSColorUsage {
  const _DSBorderColorUsage();

  DSColors get colors => const DSColors();

  DSColor get primary => colors.gray.shape300;
  DSColor get secondary => colors.gray.shape200;
  DSColor get tertiary => colors.gray.shape100;
  DSColor get brand => colors.brand.shape500;
  DSColor get error => colors.orange.shade600;
  DSColor get success => colors.green.shape500;
}
