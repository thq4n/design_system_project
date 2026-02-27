part of '../../ds_colors_core.dart';

class _DSBrandColor extends DSColor {
  const _DSBrandColor([super.value = 0xFFED2024]);

  // Primary Brand Color and its shades
  @override
  DSColor get black => const _DSBlueColor(0xFF000000);
  @override
  DSColor get white => const _DSBlueColor(0xFFFFFFFF);
  @override
  @override
  DSColor get shade950 => const _DSBrandColor(0xFF55160C);
  @override
  DSColor get shade900 => const _DSBrandColor(0xFF7A271A);
  @override
  DSColor get shade800 => const _DSBrandColor(0xFF912D18);
  @override
  DSColor get shade700 => const _DSBrandColor(0xFFB42318);
  @override
  DSColor get shade600 => const _DSBrandColor(0xFFD92D20);
  @override
  DSColor get shade500 => const _DSBrandColor(
        0xFFED2024,
      ); // This is likely your main "Primary Color"

  // Tints of the Primary Brand Color
  @override
  DSColor get shade400 => const _DSBrandColor(0xFFFA7066);
  @override
  DSColor get shade300 => const _DSBrandColor(0xFFFDA29B);
  @override
  DSColor get shade200 => const _DSBrandColor(0xFFFECDCA);
  @override
  DSColor get shade100 => const _DSBrandColor(0xFFFEE4E2);
  @override
  DSColor get shade50 => const _DSBrandColor(0xFFFEF3F2);

  // You might want to add a more semantic name for the primary shade
  @override
  DSColor get primary => shade500;

  @override
  DSColor withOpacity(double opacity) {
    return _DSBrandColor(withValues(alpha: opacity).toARGB32());
  }
}
