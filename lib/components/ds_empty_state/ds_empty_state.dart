import 'package:flutter/material.dart';

import '../../design_system_project.dart';

/// Placeholder illustration used by [DSEmptyState].
enum DSEmptyStateType {
  /// Default empty list / no data.
  question,

  /// Error or failed load.
  error,

  /// Success / completed empty.
  ok,

  /// Search returned no results.
  search,

  /// Feature is under development.
  comingSoon,

  /// No network connection.
  offline,

  /// No permission / locked.
  noAccess,

  /// Empty collection / no items.
  empty,

  /// Location permission or GPS required.
  location,

  /// Waiting / not available yet.
  wait,
}

extension DSEmptyStateTypeAsset on DSEmptyStateType {
  String get assetPath {
    return switch (this) {
      DSEmptyStateType.question => DSAssets.emptyState.iconEmptyStateQuestion,
      DSEmptyStateType.error => DSAssets.emptyState.iconEmptyStateError,
      DSEmptyStateType.ok => DSAssets.emptyState.iconEmptyStateOk,
      DSEmptyStateType.search => DSAssets.emptyState.iconEmptyStateSearch,
      DSEmptyStateType.comingSoon =>
        DSAssets.emptyState.iconEmptyStateComingSoon,
      DSEmptyStateType.offline => DSAssets.emptyState.iconEmptyStateOffline,
      DSEmptyStateType.noAccess => DSAssets.emptyState.iconEmptyStateNoAccess,
      DSEmptyStateType.empty => DSAssets.emptyState.iconEmptyStateEmpty,
      DSEmptyStateType.location => DSAssets.emptyState.iconEmptyStateLocation,
      DSEmptyStateType.wait => DSAssets.emptyState.iconEmptyStateWait,
    };
  }
}

class DSEmptyState extends StatelessWidget {
  const DSEmptyState({
    super.key,
    this.type = DSEmptyStateType.question,
    this.message = 'Không có dữ liệu',
    this.subMessage,
    this.padding = const EdgeInsets.all(40),
    this.imageSize = 200,
  });

  final DSEmptyStateType type;
  final String? message;
  final String? subMessage;
  final EdgeInsetsGeometry padding;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: padding,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          DSImageView(
            source: type.assetPath,
            width: imageSize,
            height: imageSize,
          ),
          if (message != null) ...[
            SizedBox(height: DSSpacings.m),
            Text(
              message!,
              style: textTheme.lg?.semibold,
              textAlign: TextAlign.center,
            ),
          ],
          if (subMessage != null) ...[
            SizedBox(height: DSSpacings.xs),
            Text(
              subMessage!,
              style: textTheme.base?.regular.copyWithColor(
                DSColorUsages.text.tertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
