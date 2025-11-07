part of '../../ds_theme.dart';

enum DSAvaterTypes {
  defaultType,
  textType,
  logoWhiteType,
  logoRedType,
  genderType
}

class DSAvatarTheme {
  final DSColor textColor;
  final BoxDecoration decoration;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  DSAvatarTheme({
    required this.textColor,
    required this.decoration,
    this.padding = const EdgeInsets.all(0),
    this.textStyle,
  });
}
