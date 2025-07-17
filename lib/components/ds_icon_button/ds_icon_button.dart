import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../theme/ds_theme.dart';
import '../ds_image_view/ds_image_view.dart';

class DSIconButton extends StatefulWidget {
  /// The visual variant/style of the button (primary, secondary, ghost etc)
  final DSIconButtonVariants variant;

  /// The size preset of the button (small, medium, large)
  final DSIconButtonSize size;

  /// Icon displayed. Can be a String (asset path) or Widget
  final dynamic icon;

  /// Callback function triggered when button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is in disabled state
  final bool isDisabled;

  /// Whether to show loading state
  final bool isLoading;

  /// Whether the button is in activated/selected state
  final bool isActivated;

  const DSIconButton({
    super.key,
    this.variant = DSIconButtonVariants.primary,
    this.size = DSIconButtonSize.md,
    this.icon,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.isActivated = false,
  });
  @override
  State<DSIconButton> createState() => _DSIconButtonState();
}

class _DSIconButtonState extends DSStateBase<DSIconButton> {
  @override
  Widget build(BuildContext context) {
    final DSIconButtonTheme componentTheme = theme
        .extension<DSIconButtonThemeExtension>()!
        .getDSPrimaryButtonTheme(widget.variant);

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
        ? componentTheme.disableState.iconColor
        : isActivated
            ? componentTheme.activeState.iconColor
            : componentTheme.defaultState.iconColor;

    return ElevatedButton(
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
              return componentTheme.pressedState.iconColor;
            }
            return foregroundColor;
          },
        ),

        // Remove default elevation/shadow
        elevation: WidgetStateProperty.all(0),

        // Shadow color matches background
        shadowColor: WidgetStateProperty.all(
          componentTheme.defaultState.backgroundColor,
        ),

        // Surface tint color when pressed
        // surfaceTintColor: WidgetStateProperty.all(
        //     componentTheme.pressedState.backgroundColor),

        // Circular shape
        shape: WidgetStateProperty.all(
          const CircleBorder(),
        ),
      ),
      child: isLoading
          ? CupertinoActivityIndicator(
              color: foregroundColor,
              radius: (widget.size.iconSize) / 2,
            )
          : SizedBox(
              width: widget.size.iconSize,
              height: widget.size.iconSize,
              child: _buildIcon(
                widget.icon,
                componentTheme.defaultState.iconColor,
                componentTheme.pressedState.iconColor,
              ),
            ),
    );
  }

  /// Builds an icon widget from either a String asset path or Widget
  /// Applies appropriate colors based on button state
  Widget _buildIcon(dynamic icon, Color defaultColor, Color pressedColor) {
    if (icon is String) {
      return ImageView(
        source: icon,
        width: widget.size.iconSize,
        height: widget.size.iconSize,
        fit: BoxFit.contain,
        color: defaultColor,
      );
    } else if (icon is Widget) {
      // If icon is a Widget, return it as is
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          defaultColor,
          BlendMode.srcIn,
        ),
        child: icon,
      );
    } else {
      // Fallback for other types
      return const SizedBox.shrink();
    }
  }
}
