// ignore_for_file: unused_element

part of '../../ds_color_usage_core.dart';

class _BackgroundColorUsage extends ColorUsage {
  const _BackgroundColorUsage();

  static DSColor get primary => DSColors.white.primary;
  static DSColor get secondary => DSColors.gray.tint100;
  static DSColor get disable => DSColors.gray.tint100;
  static DSColor get brandPrimary => DSColors.brand.shade500;
  static DSColor get brandSecondary => DSColors.brand.tint100;
  static DSColor get errorPrimary => DSColors.orange.shade500;
  static DSColor get errorSecondary => DSColors.orange.tint100;
  static DSColor get successPrimary => DSColors.green.shade500;
  static DSColor get successSecondary => DSColors.green.tint100;
  static DSColor get waitingPrimary => DSColors.blue.shade500;
  static DSColor get waitingSecondary => DSColors.blue.tint100;
  static DSColor get overlay => DSColors.gray.shade950.withOpacity(0.5);
}
