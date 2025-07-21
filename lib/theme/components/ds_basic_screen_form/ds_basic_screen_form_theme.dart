part of '../../ds_theme.dart';

/// Theme configuration for the DSBasicScreenForm component.
///
/// Provides default styling and behavior for the basic screen form.
/// All values can be overridden by widget parameters.
class DSBasicScreenFormTheme {
  final bool showHeaderImage;
  final bool showBackButton;
  final bool hasBottomBorderRadius;
  final bool centerTitle;
  final bool showAppbarDivider;
  final bool forceCenterTitle;
  final Color? appbarColor;
  final Color? appbarForegroundColor;
  final int? titleMaxLines;
  final TextStyle? titleStyle;
  final TextStyle? desStyle;
  final Color? backgroundColor;
  final double borderRadius;

  const DSBasicScreenFormTheme({
    this.showHeaderImage = false,
    this.showBackButton = true,
    this.hasBottomBorderRadius = true,
    this.centerTitle = true,
    this.showAppbarDivider = false,
    this.forceCenterTitle = false,
    this.titleMaxLines = 1,
    this.appbarColor,
    this.appbarForegroundColor,
    this.titleStyle,
    this.desStyle,
    this.backgroundColor,
    this.borderRadius = 12.0,
  });

  DSBasicScreenFormTheme copyWith({
    bool? showHeaderImage,
    bool? showBackButton,
    bool? hasBottomBorderRadius,
    bool? centerTitle,
    bool? showAppbarDivider,
    bool? forceCenterTitle,
    Color? appbarColor,
    Color? appbarForegroundColor,
    int? titleMaxLines,
    TextStyle? titleStyle,
    TextStyle? desStyle,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    return DSBasicScreenFormTheme(
      showHeaderImage: showHeaderImage ?? this.showHeaderImage,
      showBackButton: showBackButton ?? this.showBackButton,
      hasBottomBorderRadius:
          hasBottomBorderRadius ?? this.hasBottomBorderRadius,
      centerTitle: centerTitle ?? this.centerTitle,
      showAppbarDivider: showAppbarDivider ?? this.showAppbarDivider,
      forceCenterTitle: forceCenterTitle ?? this.forceCenterTitle,
      appbarColor: appbarColor ?? this.appbarColor,
      appbarForegroundColor:
          appbarForegroundColor ?? this.appbarForegroundColor,
      titleMaxLines: titleMaxLines ?? this.titleMaxLines,
      titleStyle: titleStyle ?? this.titleStyle,
      desStyle: desStyle ?? this.desStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  /// Linearly interpolates between two themes.
  ///
  /// Used for smooth transitions between different theme states.
  DSBasicScreenFormTheme lerp(
    covariant DSBasicScreenFormTheme? other,
    double t,
  ) {
    if (other == null) {
      return copyWith();
    }
    return DSBasicScreenFormTheme(
      showHeaderImage: other.showHeaderImage,
      showBackButton: other.showBackButton,
      hasBottomBorderRadius: other.hasBottomBorderRadius,
      centerTitle: other.centerTitle,
      showAppbarDivider: other.showAppbarDivider,
      forceCenterTitle: other.forceCenterTitle,
      titleMaxLines: other.titleMaxLines,
      borderRadius: other.borderRadius,
      appbarColor: Color.lerp(appbarColor, other.appbarColor, t),
      appbarForegroundColor:
          Color.lerp(appbarForegroundColor, other.appbarForegroundColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleStyle: TextStyle.lerp(other.titleStyle, titleStyle, t),
      desStyle: TextStyle.lerp(other.desStyle, desStyle, t),
    );
  }
}
