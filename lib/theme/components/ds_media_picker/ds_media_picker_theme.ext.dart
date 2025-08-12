part of '../../ds_theme.dart';

class DSMediaPickerThemeExtension
    extends ThemeExtension<DSMediaPickerThemeExtension> {
  final DSTextTheme textTheme;

  DSMediaPickerThemeExtension({required this.textTheme});

  // Background color
  DSColor get backgroundColor => DSColorUsages.background.primary;

  // Border color
  DSColor get borderColor => DSColorUsages.border.brand;

  // Icon color
  DSColor get iconColor => DSColorUsages.icon.brand;

  // Text color
  DSColor get textColor => DSColorUsages.text.primary;

  // Text style
  TextStyle get textStyle =>
      textTheme.bodyMedium?.copyWith(
        color: DSColorUsages.text.primary,
      ) ??
      const TextStyle();

  // Icon size
  final double iconSize = DSIconSizes.size24;

  // Media pick size
  final double mediaPickSize = 80.0;

  // Dash settings
  final double dashLength = 4.0;
  final double dashGap = 4.0;
  final double dashWidth = 1.0;

  DSMediaPickerTheme get mediaPickerTheme => DSMediaPickerTheme(
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        iconColor: iconColor,
        textColor: textColor,
        textStyle: textStyle,
        iconSize: iconSize,
        mediaPickSize: mediaPickSize,
        dashLength: dashLength,
        dashGap: dashGap,
        borderWidth: dashWidth,
      );

  @override
  ThemeExtension<DSMediaPickerThemeExtension> copyWith({
    DSTextTheme? textTheme,
  }) {
    return DSMediaPickerThemeExtension(textTheme: textTheme ?? this.textTheme);
  }

  @override
  ThemeExtension<DSMediaPickerThemeExtension> lerp(
    covariant DSMediaPickerThemeExtension? other,
    double t,
  ) {
    return DSMediaPickerThemeExtension(
      textTheme: textTheme.lerp(other?.textTheme, t),
    );
  }
}
