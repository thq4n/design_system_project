import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../design_system_project.dart';

/// A widget that displays user information with avatar, name, and ID.
///
/// This widget displays a user's avatar, name, and ID in a horizontal layout.
/// It supports an optional tail widget that appears after the user information.
///
/// Example usage:
/// ```dart
/// DSUserInfo(
///   name: 'John Doe',
///   id: 'EMP001',
///   avatarUrl: 'https://example.com/avatar.jpg',
///   tailWidget: IconButton(
///     icon: Icon(Icons.more_vert),
///     onPressed: () {},
///   ),
/// )
/// ```
class DSUserInfo extends StatelessWidget {
  /// The user's name to display
  final String? name;

  /// The user's ID to display
  final String? id;

  /// Optional avatar URL. If not provided,
  /// a default avatar with initials will be shown.
  final String? avatarUrl;

  /// Optional widget displayed after the user information
  final Widget? tailWidget;

  /// Size of the avatar
  final DSAvatarSizes avatarSize;

  /// Spacing between avatar and text content
  final double spacing;

  /// Custom name text style
  final DSTextStyle? nameStyle;

  /// Custom ID text style
  final DSTextStyle? idStyle;

  /// Whether to show dashed border around the widget
  final bool showBorder;

  /// Padding inside the container
  final EdgeInsetsGeometry? padding;

  /// Border radius of the container
  final BorderRadiusGeometry? borderRadius;

  /// Margin around the container
  final EdgeInsetsGeometry? margin;

  const DSUserInfo({
    super.key,
    required this.name,
    required this.id,
    this.avatarUrl,
    this.tailWidget,
    this.avatarSize = DSAvatarSizes.sm,
    this.spacing = 8,
    this.nameStyle,
    this.idStyle,
    this.showBorder = false,
    this.padding,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    final content = Row(
      children: [
        _buildAvatar(colors),
        SizedBox(width: spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (name != null)
                Text(
                  name!,
                  style: nameStyle ?? textTheme.base?.medium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (name != null && id != null) const SizedBox(height: 4),
              if (id != null)
                Text(
                  id!,
                  style: idStyle ??
                      textTheme.sm?.regular
                          .copyWithColor(DSColorUsages.text.tertiary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        if (tailWidget != null) ...[
          SizedBox(width: spacing),
          tailWidget!,
        ],
      ],
    );

    Widget result = content;

    // Apply padding if provided
    if (padding != null) {
      result = Padding(
        padding: padding!,
        child: content,
      );
    }

    if (showBorder) {
      final defaultBorderRadius =
          borderRadius ?? DSRadiuses.radiusSm.borderRadiusGeometry;

      result = Container(
        decoration: BoxDecoration(
          color: DSColorUsages.background.primary,
          borderRadius: defaultBorderRadius,
        ),
        child: DottedBorder(
          padding: EdgeInsets.zero,
          color: DSColorUsages.border.tertiary,
          strokeWidth: 1,
          dashPattern: const [4, 4],
          borderType: BorderType.RRect,
          radius: defaultBorderRadius is BorderRadius
              ? defaultBorderRadius.topLeft
              : const Radius.circular(8),
          child: result,
        ),
      );
    }

    if (margin != null) {
      return Container(
        margin: margin,
        child: result,
      );
    }

    return result;
  }

  Widget _buildAvatar(DSColors colors) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return DSAvatar.default_(
        source: avatarUrl!,
        size: avatarSize,
      );
    }

    // Use text avatar with initials when no avatarUrl
    final displayName = name ?? '';
    return DSAvatar.text(
      source: displayName.isNotEmpty ? displayName : '?',
      size: avatarSize,
    );
  }
}
