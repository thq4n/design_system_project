import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../design_system_core/ds_color/ds_colors_core.dart';
import '../../theme/ds_theme.dart';
import '../ds_image_view/ds_image_view.dart';

class DSTag extends StatefulWidget {
  final String? label;
  final DSTagSizes size;
  final String? prefixIcon;
  final String? suffixIcon;
  final DSTagStyles style;
  final DSColor? mainColor;
  final DSColor? backgroundColor;
  final Function()? onTapPrefixIcon;
  final Function()? onTapSuffixIcon;
  final Axis direction;
  final double? crossAxisSize;

  const DSTag({
    super.key,
    this.label,
    required this.size,
    this.prefixIcon,
    this.suffixIcon,
    required this.style,
    this.mainColor,
    this.backgroundColor,
    this.onTapPrefixIcon,
    this.onTapSuffixIcon,
    this.direction = Axis.horizontal,
    this.crossAxisSize,
  });

  @override
  State<DSTag> createState() => _DSTagState();
}

class _DSTagState extends DSStateBase<DSTag> {
  late final DSTagTheme _componentTheme =
      Theme.of(context).extension<DSTagThemeExtension>()!.getDStagThem(
            widget.style,
            widget.size,
          );

  DSColor? get _mainColor {
    switch (widget.style) {
      case DSTagStyles.custom:
        return widget.mainColor;
      default:
        return _componentTheme.mainColor;
    }
  }

  DSColor? get _backgroundColor {
    return widget.backgroundColor ?? _mainColor?.shape100;
  }

  DSColor? get _labelColor {
    return _mainColor?.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final hasPrefixIcon = widget.prefixIcon != null;
    final hasLabel = widget.label != null && widget.label!.isNotEmpty;
    final hasSuffixIcon = widget.suffixIcon != null;

    final children = <Widget>[];

    if (hasPrefixIcon) {
      children.add(
        GestureDetector(
          onTap: widget.onTapPrefixIcon,
          child: DSImageView(
            source: widget.prefixIcon ?? '',
            width: _componentTheme.iconSize,
            height: _componentTheme.iconSize,
            color: _labelColor,
          ),
        ),
      );
      // Chỉ thêm spacing nếu có phần tử tiếp theo (label hoặc suffixIcon)
      if (hasLabel || hasSuffixIcon) {
        children.add(SizedBox(width: _componentTheme.elementSpacing));
      }
    }

    if (hasLabel) {
      children.add(
        Text(
          widget.label ?? '',
          style: _componentTheme.textStyle?.copyWithColor(_labelColor),
        ),
      );
      // Chỉ thêm spacing nếu có suffixIcon
      if (hasSuffixIcon) {
        children.add(SizedBox(width: _componentTheme.elementSpacing));
      }
    }

    if (hasSuffixIcon) {
      children.add(
        GestureDetector(
          onTap: widget.onTapSuffixIcon,
          child: DSImageView(
            source: widget.suffixIcon ?? '',
            width: _componentTheme.iconSize,
            height: _componentTheme.iconSize,
            color: _labelColor,
          ),
        ),
      );
    }

    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Container(
          padding: _componentTheme.padding,
          decoration: BoxDecoration(
            borderRadius: _componentTheme.borderRadius.borderRadiusGeometry,
            color: _backgroundColor,
          ),
          child: Builder(
            builder: (context) {
              return switch (widget.direction) {
                Axis.horizontal => SizedBox(
                    height: widget.crossAxisSize,
                    child: Row(
                      children: children,
                    ),
                  ),
                Axis.vertical => SizedBox(
                    width: widget.crossAxisSize,
                    child: Column(
                      children: children,
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
