// ignore_for_file: unused_element

part of '../../ds_color_usage_core.dart';

class _DSTextColorUsage extends DSColorUsage {
  const _DSTextColorUsage();

  DSColors get colors => const DSColors();

  DSColor get primary => colors.gray.shade950;
  DSColor get secondary => colors.gray.shade700;
  DSColor get tertiary => colors.gray.shade500;
  DSColor get quaternary => colors.gray.shape400;
  DSColor get white => colors.gray.shape50;
  DSColor get disable => colors.gray.shape400;
  DSColor get linkRed => colors.brand.shade500;
  DSColor get linkBlue => colors.blue.shade500;
  DSColor get error => colors.orange.shade500;
  DSColor get success => colors.green.shade500;
}
