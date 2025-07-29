part of '../../ds_theme.dart';

/// Theme configuration for the DSBasicScreenForm component.
///
/// Provides default styling and behavior for the basic screen form with blur
/// effect. All values can be overridden by widget parameters.
class DSBasicScreenFormTheme {
  final bool showBackButton;
  final bool centerTitle;
  final Color? appbarColor;
  final Color? appbarForegroundColor;
  final int? titleMaxLines;
  final DSTextStyle? titleStyle;
  final Color? backgroundColor;
  final bool enableBlur;
  final double maxBlurOpacity;

  const DSBasicScreenFormTheme({
    this.showBackButton = true,
    this.centerTitle = true,
    this.appbarColor,
    this.appbarForegroundColor,
    this.titleMaxLines = 1,
    this.titleStyle,
    this.backgroundColor,
    this.enableBlur = true,
    this.maxBlurOpacity = 0.7,
  });

  DSBasicScreenFormTheme copyWith({
    bool? showBackButton,
    bool? centerTitle,
    Color? appbarColor,
    Color? appbarForegroundColor,
    int? titleMaxLines,
    DSTextStyle? titleStyle,
    Color? backgroundColor,
    bool? enableBlur,
    double? maxBlurOpacity,
  }) {
    return DSBasicScreenFormTheme(
      showBackButton: showBackButton ?? this.showBackButton,
      centerTitle: centerTitle ?? this.centerTitle,
      appbarColor: appbarColor ?? this.appbarColor,
      appbarForegroundColor:
          appbarForegroundColor ?? this.appbarForegroundColor,
      titleMaxLines: titleMaxLines ?? this.titleMaxLines,
      titleStyle: titleStyle ?? this.titleStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      enableBlur: enableBlur ?? this.enableBlur,
      maxBlurOpacity: maxBlurOpacity ?? this.maxBlurOpacity,
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
      showBackButton: other.showBackButton,
      centerTitle: other.centerTitle,
      titleMaxLines: other.titleMaxLines,
      enableBlur: other.enableBlur,
      maxBlurOpacity: other.maxBlurOpacity,
      appbarColor: Color.lerp(appbarColor, other.appbarColor, t),
      appbarForegroundColor:
          Color.lerp(appbarForegroundColor, other.appbarForegroundColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleStyle: titleStyle?.lerp(titleStyle, other.titleStyle, t),
    );
  }
}
