// ignore_for_file: unused_element

part of '../../ds_color_usage_core.dart';

class _DSBackgroundColorUsage extends DSColorUsage {
  const _DSBackgroundColorUsage();

  DSColors get colors => const DSColors();

  DSColor get primary => colors.white.primary;
  DSColor get secondary => colors.gray.tint100;
  DSColor get disable => colors.gray.tint100;
  DSColor get brandPrimary => colors.brand.shade500;
  DSColor get brandSecondary => colors.brand.tint100;
  DSColor get errorPrimary => colors.orange.shade500;
  DSColor get errorSecondary => colors.orange.tint100;
  DSColor get successPrimary => colors.green.shade500;
  DSColor get successSecondary => colors.green.tint100;
  DSColor get waitingPrimary => colors.blue.shade500;
  DSColor get waitingSecondary => colors.blue.tint100;
  DSColor get overlay => colors.gray.shade950.withOpacity(0.5);
  DSColor get transparent => colors.transparent;
  DSColor get scaffoldBackground => colors.other.custom(0xFFF7F2EE);
}
