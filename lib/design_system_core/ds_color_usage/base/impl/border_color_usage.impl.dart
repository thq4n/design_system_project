// ignore_for_file: unused_element

part of '../../ds_color_usage_core.dart';

class _DSBorderColorUsage extends DSColorUsage {
  const _DSBorderColorUsage();

  DSColors get colors => const DSColors();

  DSColor get primary => colors.gray.shade300;
  DSColor get secondary => colors.gray.shade200;
  DSColor get tertiary => colors.gray.shade100;
  DSColor get brand => colors.brand.shade500;
  DSColor get error => colors.orange.shade600;
  DSColor get success => colors.green.shade500;
}
