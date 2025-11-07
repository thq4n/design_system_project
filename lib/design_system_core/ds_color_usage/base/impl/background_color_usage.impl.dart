// ignore_for_file: unused_element

part of '../../ds_color_usage_core.dart';

class _DSBackgroundColorUsage extends DSColorUsage {
  const _DSBackgroundColorUsage();

  DSColors get colors => const DSColors();

  DSColor get primary => colors.gray.white;
  DSColor get secondary => colors.gray.shape100;
  DSColor get disable => colors.gray.shape100;
  DSColor get brandPrimary => colors.brand.shade500;
  DSColor get brandSecondary => colors.brand.shape100;
  DSColor get errorPrimary => colors.orange.shade500;
  DSColor get errorSecondary => colors.orange.shape100;
  DSColor get successPrimary => colors.green.shade500;
  DSColor get successSecondary => colors.green.shape100;
  DSColor get waitingPrimary => colors.blue.shade500;
  DSColor get waitingSecondary => colors.blue.shape100;
  DSColor get overlay => colors.gray.shade950.withOpacity(0.5);
  DSColor get transparent => colors.transparent;
  DSColor get scaffoldBackground => colors.other.custom(0xFFF7F2EE);
}
