import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../theme/ds_theme.dart';
import '../ds_image_view/ds_image_view.dart';

class DSButton extends StatefulWidget {
  /// The visual variant/style of the button (primary, secondary, ghost etc)
  final DSButtonVariants variant;

  /// The size preset of the button (small, medium, large)
  final DSButtonSize size;

  /// The text label displayed on the button
  final String? label;

  /// Icon displayed before the label. Can be a String (asset path) or Widget
  final dynamic prefixIcon;

  /// Icon displayed after the label. Can be a String (asset path) or Widget
  final dynamic suffixIcon;

  /// Callback function triggered when button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is in disabled state
  final bool isDisabled;

  /// Whether to show loading state
  final bool isLoading;

  /// Whether the button is in activated/selected state
  final bool isActivated;

  const DSButton({
    super.key,
    this.variant = DSButtonVariants.primary,
    this.size = DSButtonSize.md,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.isActivated = false,
  });

  @override
  State<DSButton> createState() => _DSButtonState();
}

class _DSButtonState extends DSStateBase<DSButton> {
  final ValueNotifier<bool> _isPressedNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final DSButtonTheme componentTheme =
        theme.extension<DSButtonThemeExtension>()!.getDSPrimaryButtonTheme(
              widget.variant,
            );

    final isDisabled = widget.isDisabled;

    final isActivated = widget.isActivated;

    final isLoading = widget.isLoading;

    final onPressed = isDisabled || isLoading ? null : widget.onPressed;

    final backgroundColor = isDisabled
        ? componentTheme.disableState.backgroundColor
        : isActivated
            ? componentTheme.activeState.backgroundColor
            : componentTheme.defaultState.backgroundColor;

    final overlayColor = isDisabled
        ? componentTheme.disableState.backgroundColor
        : componentTheme.pressedState.backgroundColor;

    final foregroundColor = isDisabled
        ? componentTheme.disableState.textStyle?.color
        : isActivated
            ? componentTheme.activeState.textStyle?.color
            : componentTheme.defaultState.textStyle?.color;

    final textStyle = isDisabled
        ? componentTheme.disableState.textStyle
        : isActivated
            ? componentTheme.activeState.textStyle
            : componentTheme.defaultState.textStyle;

    return GestureDetector(
      onTapDown: (_) => _isPressedNotifier.value = true,
      onTapUp: (_) => _isPressedNotifier.value = false,
      onTapCancel: () => _isPressedNotifier.value = false,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // Padding around button content
          padding: WidgetStateProperty.all(widget.size.padding),

          // Background color based on button state (default/disabled/activated)
          backgroundColor: WidgetStateProperty.all(backgroundColor),

          // Overlay color when button is pressed
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return overlayColor;
              }
              return null;
            },
          ),

          // Text/icon color based on button state
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return componentTheme.pressedState.textStyle?.color;
              }
              return foregroundColor;
            },
          ),

          // Remove default elevation/shadow
          elevation: WidgetStateProperty.all(0),

          // Disable ripple effect for ghost variant
          splashFactory: widget.variant == DSButtonVariants.ghost
              ? NoSplash.splashFactory
              : null,

          // Shadow color matches background
          shadowColor: WidgetStateProperty.all(
            componentTheme.defaultState.backgroundColor,
          ),

          // Surface tint color when pressed
          // surfaceTintColor: WidgetStateProperty.all(
          //     componentTheme.pressedState.backgroundColor),

          // Rounded corners shape
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          textStyle: WidgetStateProperty.resolveWith<TextStyle?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return componentTheme.pressedState.textStyle;
              }
              return textStyle;
            },
          ),
        ),
        child: isLoading
            ? CupertinoActivityIndicator(
                color: foregroundColor,
                radius: (textStyle?.fontSize ?? 0) / 2,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.prefixIcon != null) ...[
                    SizedBox(
                      width: widget.size.prefixIconSize,
                      height: widget.size.prefixIconSize,
                      child: _buildIcon(
                        widget.prefixIcon,
                        componentTheme.defaultState.prefixIconColor,
                        componentTheme.pressedState.prefixIconColor,
                      ),
                    ),
                    SizedBox(width: widget.size.elementSpacing),
                  ],
                  Text(
                    widget.label ?? '',
                    // Let foregroundColor handle text color changes
                  ),
                  if (widget.suffixIcon != null) ...[
                    SizedBox(width: widget.size.elementSpacing),
                    SizedBox(
                      width: widget.size.suffixIconSize,
                      height: widget.size.suffixIconSize,
                      child: _buildIcon(
                        widget.suffixIcon,
                        componentTheme.defaultState.suffixIconColor,
                        componentTheme.pressedState.suffixIconColor,
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  /// Builds an icon widget from either a String asset path or Widget
  /// Applies appropriate colors based on button state
  Widget _buildIcon(dynamic icon, Color defaultColor, Color pressedColor) {
    if (icon is String) {
      return ValueListenableBuilder(
        valueListenable: _isPressedNotifier,
        builder: (context, isPressed, child) {
          // If icon is a string (path), use ColorFiltered to change color
          final iconColor = isPressed ? pressedColor : defaultColor;

          return ColorFiltered(
            colorFilter: ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
            child: DSImageView(
              source: icon,
              width: widget.size.prefixIconSize,
              height: widget.size.prefixIconSize,
              fit: BoxFit.contain,
            ),
          );
        },
      );
    } else if (icon is Widget) {
      // If icon is a Widget, return it as is
      return icon;
    } else {
      // Fallback for other types
      return const SizedBox.shrink();
    }
  }
}
